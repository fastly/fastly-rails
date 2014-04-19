# Fastly Rails Plugin

Fastly dynamic caching integration for Rails.

This plugin does three main things:
- Provides instance and class methods on ActiveRecord objects to help with surrogate keys, including purging
- Sets up Cache-Control and Surrogate-Control response headers
- Provides a controller helper method to set surrogate keys on responses

If you're not familiar with Fastly Surrogate Keys, you might want to check out [API Caching](http://www.fastly.com/blog/api-caching-part-1) and [Fastly Surrogate Keys](http://www.fastly.com/blog/surrogate-keys-part-1) for a primer.

# Setup

Add to your Gemfile

````ruby
gem 'fastly-rails'
````

## Configuration

Create an initializer for Fastly configuration

````ruby
FastlyRails.configure do |c|
  c.api_key = 'SOMETHING'
  c.user = 'SOMEONE'
  c.password = 'SOMEPASS'
  c.max_age = 86400 # time in seconds, optional, defaults to 2592000
end
````
> Note: purging only requires that you authenticate with your `api_key`. `user` and `password` are added for full compatibility with the Fastly API.

## Usage

### Surrogate Keys

Surrogate keys are what Fastly uses to purge indivual objects from our caches.

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
  "my_custom_record_key" #you should use something unique to each record
end
````

### Headers

By default we have included a [before_filter](https://github.com/fastly/fastly-rails/blob/master/lib/fastly_rails/action_controller/cache_control_headers.rb#L6) that sets Cache-Control and Surrogate-Control header with a default of 30 days (remember you can configure this, see the initializer setup above).

It's up to you to set Surrogate-Key headers for objects that you want to be able to purge.

To do this use the `set_surrogate_key_header` method on GET actions.

````ruby
class BooksController < ApplicationController
  # this before_filter included by inheriting from ActionController
  # before_filter :set_cache_control_headers, only: [:index, :show]
  # you can add or remove actions as need by setting another before_filter
  # e.g. before_filter :set_cache_control_headers, only: [:my_custom_action]
  # or skip_before_filter :set_cache_control_headers, only: [:index]

  def index
    @books = Book.all
    set_surrogate_key_header @book.table_key
  end

  def show
    @book = Book.find(params[:id])
    set_surrogate_key_header @book.record_key
  end
end
````

### Purges

Any object that inherits from ActiveRecord will have `purge_all` and `table_key` class methods available as well as `purge` and `purge_all` instance methods.

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
class Book < ActiveRecord
  after_create :purge_all
  after_save :purge
  after_destroy :purge, :purge_all
  ...

end
````

We have left these out intentially, as they could potentially cause issues when running locally or testing.


### Example

Check out our example [todo app](https://github.com/mmay/todo) which has a full example of fastly-rails integration in a simple rails app.

## Future Work

- Add an option to send purges in batches.

> This will cut down on response delay from waiting for large amounts of purges to happen. This would primarily be geared towards write-heavy apps.

- Your feedback

## Testing

This engine is capable of testing against multiple versions of Rails.  It uses the appraisal gem.  To make this happen, use the appraisal command in lieu of `rake test`:

````ruby
appraisal rake test # tests against all the defined versions in the Appraisals file

appraisal rails-3 rake test # finds a defined version in the Appraisals file called "rails-3" and only runs tests against this version
````

## Credits

This plugin was developed with lots of help from our friend at [Hotel Tonight](http://www.hoteltonight.com), [Harlow Ward](https://twitter.com/futuresanta). Check out his blog about [Cache Invalidation with Fastly Surrogate Keys](http://www.hward.com/varnish-cache-invalidation-with-fastly-surrogate-keys) which is where many of the ideas used in this plugin originated.

--
This project rocks and uses MIT-LICENSE.
