# Lampwick

This gem makes it easy to run an autostage script, in the event that the puppet environment needs 'PULL' only and cannot use git-hooks

[![Build Status](https://travis-ci.org/azizshamim/lampwick.png?branch=master)](https://travis-ci.org/azizshamim/lampwick)

* **TODO: auth for private repos**

## Installation

Add this line to your application's Gemfile:

```
gem 'lampwick'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install lampwick
```

## Usage

Create a configuration file with the following elements
```
---
  git:      'git repository' (e.g. https://github.com/fup/example.git or git@github.com:fup/example
  target:   'path to the directory where the environments will be set up'
  repo:     'path to the directory where the repository will be initially cloned' [Optional]
```
If using basic auth, include it in the URI (e.g. https://**user**:**password**@github.com/fup/somerepo.git)

If using ssh, make sure the key is loaded using keyagent, key location is currently unsupported.

For GitHub private repos, username and password are needed.

```shell
lampwick --config <config_file> [--named] [--purge]
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
