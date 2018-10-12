# Fastly Rails Plugin [![Build Status](https://travis-ci.org/fastly/fastly-rails.svg?branch=master)](https://travis-ci.org/fastly/fastly-rails)

Fastly dynamic caching integration for Rails.

To use Fastly dynamic caching, you tag *any* response you wish to cache with unique Surrogate-Key HTTP Header(s) and then hit the Fastly API purge endpoint with the surrogate key when the response changes. The purge instantly replaces the cached response with a fresh response from origin.

This plugin provides three main things:
- Instance and class methods on ActiveRecord (or Mongoid) objects for surrogate keys and purging
- Controller helpers to set Cache-Control and Surrogate-Control response headers
- A controller helper to set Surrogate-Key headers on responses

If you're not familiar with Fastly Surrogate Keys, you might want to check out [API Caching](http://www.fastly.com/blog/api-caching-part-1) and [Fastly Surrogate Keys](http://www.fastly.com/blog/surrogate-keys-part-1) for a primer.

# Setup

Add to your Gemfile

````ruby
gem 'fastly-rails'
````

## Configuration

For information about how to find your Fastly API Key or a Fastly Service ID, refer to our [documentation](https://docs.fastly.com/guides/account-management-and-security/finding-and-managing-your-account-info).

Create an initializer for Fastly configuration

````ruby
FastlyRails.configure do |c|
  c.api_key = ENV['FASTLY_API_KEY']  # Fastly api key, required
  c.max_age = 86400                  # time in seconds, optional, defaults to 2592000 (30 days)
  c.stale_while_revalidate = 86400   # time in seconds, optional, defaults to nil
  c.stale_if_error = 86400           # time in seconds, optional, defaults to nil
  c.service_id = ENV['SERVICE_ID']   # The Fastly service you will be using, required
  c.purging_enabled = !Rails.env.development? # No need to configure a client locally (AVAILABLE ONLY AS OF 0.4.0)
end
````
> Note: purging only requires that you authenticate with your `api_key`. However, you can provide a `user` and `password` if you are using other endpoints in fastly-ruby that require full-auth.
> Also, you must provide a service_id for purges to work.

## Usage

### Surrogate Keys

Surrogate keys are what Fastly uses to purge groups of individual objects from our caches.

This plugin adds a few methods to generate surrogate keys automatically.  `table_key` and `record_key` methods are added to any ActiveRecord::Base instance.  `table_key` is also added to any ActiveRecord::Base class.  In fact, `table_key` on an instance just calls `table_key` on the class.

We've chosen a simple surrogate key pattern by default. It is:

````ruby
table_key: self.class.table_key # calls table_name on the class
record_key: "#{table_key}/#{self.id}"
````

e.g. If you have an ActiveRecord Model named Book.

````ruby
table key: books
record key: books/1, books/2, books/3, etc...
````

You can easily override these methods in your models to use custom surrogate keys that may fit your specific application better:

````ruby
def self.table_key
  "my_custom_table_key"
end

def record_key
  "my_custom_record_key"# Ensure these are unique for each record
end
````

### Headers

This plugin adds a `set_cache_control_headers` method to ActionController. You'll need to add this in a `before_action` or `after_action` [see note on cookies below](https://github.com/fastly/fastly-rails#sessions-cookies-and-private-data) to any controller action that you wish to edge cache (see example below). The method sets Cache-Control and Surrogate-Control HTTP Headers with a default of 30 days (remember you can configure this, see the initializer setup above).

It's up to you to set Surrogate-Key headers for objects that you want to be able to purge.

To do this use the `set_surrogate_key_header` method on GET actions.

````ruby
class BooksController < ApplicationController
  # include this before_action in controller endpoints that you wish to edge cache
  before_action :set_cache_control_headers, only: [:index, :show]
  # This can be used with any customer actions. Set these headers for GETs that you want to cache
  # e.g. before_action :set_cache_control_headers, only: [:index, :show, :my_custom_action]

  def index
    @books = Book.all
    set_surrogate_key_header 'books', @books.map(&:record_key)
  end

  def show
    @book = Book.find(params[:id])
    set_surrogate_key_header @book.record_key
  end
end
````

### Purges

Any object that inherits from ActiveRecord will have `purge_all`, `soft_purge_all`, and `table_key` class methods available as well as `purge`, `soft_purge`, `purge_all`, and `soft_purge_all` instance methods.

Example usage is show below.

````ruby
class BooksController < ApplicationController

  def create
    @book = Book.new(params)
    if @book.save
      @book.purge_all
      render @book
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(params)
      @book.purge
      render @book
    end
  end

  def delete
    @book = Book.find(params[:id])
    if @book.destroy
      @book.purge # purge the record
      @book.purge_all # purge the collection so the record is no longer there
    end
  end
end
````

To simplify controller methods, you could use ActiveRecord callbacks. e.g.

````ruby
class Book < ActiveRecord::Base
  after_create :purge_all
  after_save :purge
  after_destroy :purge, :purge_all
  ...

end
````

We have left these out intentially, as they could potentially cause issues when running locally or testing. If you do use these, pay attention, as using callbacks could also inadvertently overwrite HTTP Headers like Cache-Control or Set-Cookie and cause responses to not be properly cached.

### Service id

One thing to note is that currently we expect a service_id to be defined in your FastlyRails.configuration.  However, we've added localized methods so that your models can override your global service_id, if you needed to operate on more than one for any reason.  NOTE: As of 0.3.0, we've renamed the class-level and instance-level `service_id` methods to `fastly_service_identifier` in the active_record and mongoid mix-ins.  See the CHANGELOG for a link to the Github issue.

Currently, this would require you to basically redefine `fastly_service_identifier` on the class level of your model:

````ruby
class Book < ActiveRecord::Base
  def self.fastly_service_identifier
    'MYSERVICEID'
  end
end
````


### Sessions, Cookies, and private data

By default, Fastly will not cache any response containing a `Set-Cookie` header. In general, this is beneficial because caching responses that contain sensitive data is typically not done on shared caches.

In this plugin the `set_cache_control_headers` method removes the `Set-Cookie` header from a
request. In some cases, other libraries, particularily middleware, may insert or modify HTTP Headers outside the scope of where the `set_cache_control_heades` method is invoked in a controller action. For example, some authentication middleware will add a `Set-Cookie` header into requests *after* fastly-rails removes it.

This can cause some requests that can (and should) be cached to not be cached due to the presence of `Set-Cookie`.

In order to remove the `Set-Cookie` header in these cases, fastly-rails provides an optional
piece of middleware that removes `Set-Cookie` when the `Surrogate-Control` or `Surrogate-Key`
header is present (the `Surrogate-Control` header is also inserted by the
`set_cache_control_headers` method and indicates that you want the endpoint to
be cached by Fastly and do not need cookies).

#### fastly-rails middleware to delete `Set-Cookie`

To override a piece of middleware in Rails, insert custom middleware before
it. Once you've identified which middleware is inserting the `Set-Cookie`
header, add the following (in this example, `ExampleMiddleware` is what we are
trying to override`:

```ruby
# config/application.rb

  config.middleware.insert_before(
    ExampleMiddleware,
    "FastlyRails::Rack::RemoveSetCookieHeader"
  )
```



### Example

Check out our example [todo app](https://github.com/mmay/todo) which has a full example of fastly-rails integration in a simple rails app.

## Future Work

- Add an option to send purges in batches.

> This will cut down on response delay from waiting for large amounts of purges to happen. This would primarily be geared towards write-heavy apps.

- Your feedback

## Testing

First, install all required gems:

```sh
$ appraisal install
```

This engine is capable of testing against multiple versions of Rails.  It uses the appraisal gem.  To make this happen, use the appraisal command in lieu of `rake test`:

```sh
$ appraisal rake test # tests against all the defined versions in the Appraisals file

$ appraisal rails-3 rake test # finds a defined version in the Appraisals file called "rails-3" and only runs tests against this version
````

## Supported Platforms
We [run tests](https://travis-ci.org/fastly/fastly-rails) using all combinations of the following versions of Ruby and Rails:

Ruby:
  - 1.9.3
  - 2.1.1

Rails:
  - v3.2.18
  - v4.0.5
  - v4.1.1

### Other Platforms
As of v0.1.2, *experimental* Mongoid support was added by @joshfrench of [Upworthy](http://www.upworthy.com/).

## Credits

This plugin was developed by [Fastly](http://www.fastly.com/) with lots of help from our friend at [Hotel Tonight](http://www.hoteltonight.com), [Harlow Ward](https://twitter.com/futuresanta). Check out his blog about [Cache Invalidation with Fastly Surrogate Keys](http://www.hward.com/varnish-cache-invalidation-with-fastly-surrogate-keys) which is where many of the ideas used in this plugin originated.

--
This project rocks and uses MIT-LICENSE.
