# Transport for London API Client

This gem aims to provide a simple, programmatic ruby client that allows
native ruby applications to seamlessly interact with Transport for
London's live APIs.

[![Build Status](https://travis-ci.org/LukeHackett/tfl_api_client.svg?branch=master)](https://travis-ci.org/LukeHackett/tfl_api_client)
[![Dependency Status](https://gemnasium.com/LukeHackett/tfl_api_client.svg)](https://gemnasium.com/LukeHackett/tfl_api_client)
[![Code Climate](https://codeclimate.com/github/LukeHackett/tfl_api_client/badges/gpa.svg)](https://codeclimate.com/github/LukeHackett/tfl_api_client)
[![Coverage Status](https://coveralls.io/repos/LukeHackett/tfl_api_client/badge.svg?branch=master&service=github)](https://coveralls.io/github/LukeHackett/tfl_api_client?branch=master)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tfl_api_client'
```

And then install via bundler:

    $ bundle install

Or install it yourself as:

    $ gem install tfl_api_client


### Supported Ruby Versions

The TFL API Client supports Ruby 2.0.0 or higher. 


## Usage

TFL API Client has been designed to be as simple as possible to work with.

To use the TFL API, developers should [register][tfl_registration] for a set
of API credentials (an Application ID and Application Key).

Once valid API credentials have been obtained, you will need to pass the 
Application ID and Application Key upon initialisation of the client:

```ruby
@client = TflApi::Client.new(app_id: TFL_APP_ID, app_key: TFL_APP_KEY)
````

In addition to the above mandatory parameters, a number of optional parameters
can be passed:

| Option       | Default Value          | Description                                         |
| ------------ | ---------------------- | --------------------------------------------------- |
| host         | https://api.tfl.gov.uk | TFL API's host url                                  |
| logger       | a new Logger instance  | Logger object to log into                           |
| log_level    | INFO                   | The log level to logging at                         |
| log_location | STDOUT                 | Location to send all logs (can be a file or STDOUT) |

[registration]: https://api-portal.tfl.gov.uk


## Changelog

See the [CHANGELOG][changelog] for a list of changes.

[changelog]: CHANGELOG.md


## Contributing

This project started in order to fill a gap in the current offers for 
gems that provide a programmatic interface to TFL's API. 

The TFL API Client gem was originally developed by [Luke Hackett][luke_hackett], 
and is not an official TFL client.

In the spirit of [free software][free-sw], **everyone** is encouraged to 
help improve this project.

Here are some ways in which *you* can contribute:

* by using prerelease versions
* by reporting [bugs][issues]
* by suggesting [new features][issues]
* by writing or editing documentation
* by writing code ( **no patch is too small** : fix typos, add comments, clean up inconsistent whitespace )
* by refactoring code
* by reviewing code

[luke_hackett]: http://www.lukehackett.com
[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html
[issues]: https://github.com/LukeHackett/tfl_api_client/issues

### Submitting an Issue

I utilise the [GitHub issue tracking][issues] to track bugs and features.
Before submitting a bug report or feature request, check to make sure it
hasn't already been submitted.

When submitting a bug report, please include a [Gist][gist] that includes
a stack trace and any details that may be necessary to reproduce the bug,
including your gem version, Ruby version, and operating system. 

Ideally, a bug report should include a pull request with failing specs.

[gist]: https://gist.github.com/

### Submitting a Pull Request

1. [Fork][fork] the [repository][repo].
2. [Create a feature branch][branch] using the [gitflow][gitflow] naming convention e.g. `feature/my-new-feature`.
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. [Submit a pull request][pr].

[repo]: https://github.com/LukeHackett/tfl_api_client/tree/master
[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[pr]: https://help.github.com/articles/using-pull-requests/
[gitflow]: http://danielkummer.github.io/git-flow-cheatsheet/#features

### Notes

* Please add tests if you changed code - contributions without tests won't be accepted.
* Please don't update the Gem version.

The contributing guidelines was inspired by [Middleman-Heroku][middleman] 
and [Factory Girl][factory_girl]. 

[middleman]: https://github.com/middleman/middleman-heroku/blob/master/CONTRIBUTING.md
[factory_girl]: https://github.com/thoughtbot/factory_girl/blob/master/CONTRIBUTING.md


## License

Copyright (c) 2015 - 2017 Luke Hackett. MIT Licensed, see [LICENSE][license] for details.

[license]: LICENSE

