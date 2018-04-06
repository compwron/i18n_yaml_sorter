require 'spec_helper'

describe I18nYamlSorter do
  it 'test_should_sort_complex_sample_file' do
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out.yml') do |expected_out|
        expect(expected_out.read).to eq(sorter.sort)
      end
    end
  end

  it 'test_should_rails_i18n_default_file' do
    open(File.dirname(__FILE__) + '/in_rails.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_rails.yml') do |expected_out|
        expect(expected_out.read).to eq(sorter.sort)
      end
    end
  end

  it 'test_should_sort_simple_text_file' do
    open(File.dirname(__FILE__) + '/in_simple.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/out_simple.yml') do |expected_out|
        expect(expected_out.read).to eq(sorter.sort)
      end
    end
  end

  it 'test_should_not_alter_the_serialized_yaml' do
    #ordering should'n t change a thing, since hashes don't have order in Ruby
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      present = YAML::load(file.read)
      file.rewind
      future = YAML::load(sorter.sort)
      expect(present).to eq(future)
    end
  end

  it 'test_command_line_should_work_in_stdin' do
    output = `#{File.dirname(__FILE__)}/../bin/sort_yaml < #{File.dirname(__FILE__)}/in.yml`
    open(File.dirname(__FILE__) + '/out.yml') do |expected_out|
      expect(expected_out.read).to eq(output)
    end
  end
end
