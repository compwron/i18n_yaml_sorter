require 'spec_helper'

describe I18nYamlSorter do

  def compare_sorted(in_file, out_file)
    open(File.dirname(__FILE__) + '/' + in_file) do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      open(File.dirname(__FILE__) + '/' + out_file) do |expected_out|
        expect(expected_out.read).to eq(sorter.sort)
      end
    end
  end

  it 'sorts simple file and removes empty lines' do
    compare_sorted('in_simple.yml', 'out_simple.yml')
  end

  it 'sorts multi-indented keys with quotes and symbols and accents and comments' do
    compare_sorted('in.yml', 'out.yml')
  end

  it 'sorts rails i18n style default file' do
    compare_sorted('in_rails.yml', 'out_rails.yml')
  end

  it 'does not change the input file' do
    # ordering shouldn't change anything, since hashes don't have order in Ruby
    open(File.dirname(__FILE__) + '/in.yml') do |file|
      sorter = I18nYamlSorter::Sorter.new(file)
      present = YAML::load(file.read)
      file.rewind
      future = YAML::load(sorter.sort)
      expect(present).to eq(future)
    end
  end

  it 'runs commandline command' do
    output = `#{File.dirname(__FILE__)}/../bin/sort_yaml < #{File.dirname(__FILE__)}/in.yml`
    open(File.dirname(__FILE__) + '/out.yml') do |expected_out|
      expect(expected_out.read).to eq(output)
    end
  end

  it 'sorts keys containing parenthesis' do
    compare_sorted('in_W.yml', 'out_W.yml')
  end
end
