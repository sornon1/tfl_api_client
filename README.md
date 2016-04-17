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

Ruby 1.9.3 is currently not supported, but will be supported in future 
iterations of the gem.


## Usage

Checkout the [Getting Started][getting_started] guide.

[getting_started]: GETTING_STARTED.md


## Changelog

See [CHANGELOG][changelog] for a list of changes.

[changelog]: changelog.md


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

Copyright (c) 2015 Luke Hackett. MIT Licensed, see [LICENSE][license] for details.

[license]: LICENSE

