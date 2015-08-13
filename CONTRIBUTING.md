# Contributing to TFL API Client

This project started in order to fill a gap in the current offers for gems 
that provide a programmatic interface to TFL's API. 

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

[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html
[issues]: https://github.com/LukeHackett/tfl_api_client/issues


## Submitting an Issue

I utilise the [GitHub issue tracking][issues] to track bugs and features.
Before submitting a bug report or feature request, check to make sure it
hasn't already been submitted.

When submitting a bug report, please include a [Gist][] that includes a stack 
trace and any details that may be necessary to reproduce the bug, including 
your gem version, Ruby version, and operating system. 

Ideally, a bug report should include a pull request with failing specs.

[gist]: https://gist.github.com/


## Submitting a Pull Request

1. [Fork][fork] the [repository][repo].
2. [Create a feature branch][branch] using the [gitflow][] naming convention e.g. `feature/my-new-feature`.
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. [Submit a pull request][pr].

[repo]: https://github.com/LukeHackett/tfl_api_client/tree/master
[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[pr]: https://help.github.com/articles/using-pull-requests/

[gitflow]: http://danielkummer.github.io/git-flow-cheatsheet/#features


## Notes

* Please add tests if you changed code. Contributions without tests won't be accepted.
* Please don't update the Gem version.

Inspired by [Middleman-Heroku][middleman] and [Factory Girl][factory_girl]. 

[middleman]: https://github.com/middleman/middleman-heroku/blob/master/CONTRIBUTING.md
[factory_girl]: https://github.com/thoughtbot/factory_girl/blob/master/CONTRIBUTING.md
