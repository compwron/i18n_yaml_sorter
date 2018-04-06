lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_yaml_sorter/version'

Gem::Specification.new do |s|
  s.name = "i18n_yaml_sorter_2"
  s.version = I18nYamlSorter::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bernardo de P\u{e1}dua", 'compiledwrong']
  s.date = "2081-04-06"
  s.description = " Allows you to deep sort YAML files that are mainly composed of \n      nested hashes and string values. Great to sort your rails I18n YAML files. You can easily\n      add it to a textmate bundle, rake task, or just use the included regular comand line tool. \n    "
  s.email = ["berpasan@gmail.com", 'compiledwrong+i18n_yaml_sorter@gmail.com']
  s.executables = ["sort_yaml"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/sort_yaml",
    "i18n_yaml_sorter.gemspec",
    "lib/i18n_yaml_sorter.rb",
    "lib/i18n_yaml_sorter/railtie.rb",
    "lib/i18n_yaml_sorter/sorter.rb",
    "lib/tasks/i18n_yaml_sorter.rake",
    "textmate/YAML Sort.tmbundle/Commands/Sort YAML.tmCommand",
    "textmate/YAML Sort.tmbundle/info.plist"
  ]
  s.homepage = "http://github.com/redealumni/i18n_yaml_sorter"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.summary = "A I18n YAML deep sorter that will keep your locales organized and not screw up your text formating"

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end

