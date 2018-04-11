lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_yaml_sorter/version'

Gem::Specification.new do |s|
  s.name = 'i18n_yaml_sorter_2'
  s.version = I18nYamlSorter::VERSION
  s.authors = ["Bernardo de P\u{e1}dua", 'compiledwrong']
  s.email = ['berpasan@gmail.com', 'compiledwrong+i18n_yaml_sorter@gmail.com']
  s.summary = 'A I18n YAML deep sorter that will keep your locales organized and not screw up your text formating'
  s.description = 'Allows you to deep sort YAML files that are mainly composed of nested hashes and string values. Great to sort your rails I18n YAML files. You can easily add it to a textmate bundle, rake task, or just use the included regular comand line tool.'
  s.homepage = 'https://github.com/compwron/i18n_yaml_sorter'
  s.license = 'MIT'
  s.executables = ['sort_yaml']
  s.files = Dir['{lib,spec}/**/*'].select { |f| File.file?(f) } + %w(LICENSE Rakefile README.md)
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
end
