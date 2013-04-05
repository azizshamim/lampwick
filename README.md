# Autostage

This gem makes it easy to run an autostager script, in the event that the puppet environment needs 'PULL' only and cannot use git-hooks

[![Build Status](https://travis-ci.org/[YOUR_GITHUB_USERNAME]/[YOUR_PROJECT_NAME].png)](https://travis-ci.org/azizshamim/puppet-autostager)

* **TODO: auth for private repos**
* **TODO: thor binary/runner**

## Installation

Add this line to your application's Gemfile:

    gem 'puppet-autostage'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet-autostage

## Usage

Create a configuration file with the following elements
```
---
  git:      'git repository' (e.g. https://github.com/fup/example.git or git@github.com:fup/example
  target:   'path to the directory where the environments will be set up'
  temp_dir: 'path to the directory where the repository will be initially cloned' [Optional]
```
If using basic auth, include it in the URI (e.g. https://**user**:**password**@github.com/fup/somerepo.git)

If using ssh, include a path to your key (**Unsupported for now**)

For private repos, username and password are needed.

```shell
autostage --config <config_file>
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
