# i18n_yaml_sorter

[![Build Status](https://travis-ci.org/compwron/i18n_yaml_sorter.svg?branch=master)](https://travis-ci.org/compwron/i18n_yaml_sorter)
[![Gem Version](https://badge.fury.io/rb/i18n_yaml_sorter_2.svg)](http://badge.fury.io/rb/i18n_yaml_sorter_2)

## History

This is a fork of https://github.com/redealumni/i18n_yaml_sorter and the original works just fine. :)

## Purpose

Large yaml files can be frustrating to navigate. This helps. This is intended to specifically work with the YAML Hash keys commonly used by the i18n gem and rails apps.

This does not parse YAML, it just sorts the lines. 

## Usage
    
    gem install i18n_yaml_sorter_2
    sort_yaml < in.yml > out.yml
    mv out.yml in.yml
    
or

    require 'i18n_yaml_sorter'
    I18nYamlSorter::Sorter.new(File.open('path/to/file.yml'))  

## Textmate Bundle

Run this command in the Terminal to install it:

    $ sort_yaml -i

A TextMate bundle, named "Yaml Sort" will be installed in your user home path.
Press "Shift+Command+S" or use the Bundles menu to invoke it. The opened yaml
file  (or just the part of it that is selected) will be sorted. To edit the
selected part of the file, make sure it is valid YAML by itself, or your yaml
file might be corrupted (you can always Undo if you mess up).

## Rails Rake Task

Declare it as a dependency in your app Gemfile, under the development group:

    gem 'i18n_yaml_sorter_2', :group => :development

Run bundle install under your Rails' app:

    $ bundle install

Now run the rake task under your Rails' app to sort all the i18n files in your
`config/locales` dir:

    $rake i18n:sort

## Development

    rake spec # run tests
    rake release # build installable/publishable gem

## Copyright

Copyright (c) 2010-2011 Bernardo de Pádua. MIT License (See LICENCE).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/aws_agcod/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
