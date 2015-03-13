# Changelog

### 0.3.0 / 2015-03-12
  * Potentially Breaking Change: rename `service_id` methods to `fastly_service_identifier` in both the active_record and mongoid mix-ins (in response to https://github.com/fastly/fastly-rails/issues/36)

### 0.2.0 / 2014-10-02
  * Require API key for purge requests
  * Bumps fastly-ruby gem dep to 1.1.4

### 0.1.7 / 2014-10-01
  * Fix regression with erroneously sending `purge_by_key` method as class-level instead of instance-level (@jumph4x )

### 0.1.6 / 2014-09-23
  * Add optional middleware to strip `Set-Cookie` HTTP Header (Thanks @jessieay!)
  * !! Introduces erroneous purges. Use 0.1.7 instead !!

### 0.1.5 / 2014-09-04
  * Surrogate key helper can now accept multiple keys (PR by @jessieay)

### 0.1.4 / 2014-06-12
  * Bump version of `fastly` gem used (see: [issue #23](https://github.com/fastly/fastly-rails/issues/23))
  * Add `test:setup` and `test:all` Rake tasks
  * Add `webmock` as full development dependency

### 0.1.3 / 2014-06-03
  * Service_id configuration (required as of 0.1.3)
  * Fix purging (bug posted by @scaryguy)

### 0.1.2 / 2014-05-07
  * Experimental Mongoid support (@joshfrench)
  * Explicitly test against Rails 4.1

### 0.1.1 / 2014-04-28
  * Lots of cleanup and documentation improvements (@gabebw, @chaslemley, @harlow)

### 0.1.0 / 2014-04-17
  * Initial release
