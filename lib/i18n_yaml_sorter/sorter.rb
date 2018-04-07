module I18nYamlSorter
  class Sorter
    def initialize(io_input)
      @io_input = io_input
    end

    def sort
      @array = break_blocks_into_array
      @current_array_index = 0
      sorted_yaml_from_blocks_array
    end

    private

    LINE_BREAK = "\n"

    def is_blank?(line)
      line.match(/^\s*$/)
    end

    def matches_key_value_line?(line)
      line.match(/^(\s*)(["']?[\w\-]+["']?)(: )(\s*)(\S.*\S)(\s*)$/)
    end

    def matches_starts_with_quote?(key_value_parse)
      key_value_parse[5].match(/^["']/)[0] rescue nil
    end

    def matches_ends_with_quote?(key_value_parse)
      key_value_parse[5].match(/[^\\](["'])$/)[1] rescue nil
    end

    def append_next_lines_until_closing_quote!(array, starts_with_quote)
      loop do
        content_line = @io_input.gets || break
        content_line.chomp!
        array.last << content_line.concat(LINE_BREAK)
        break if content_line.match(/[^\\][#{starts_with_quote}]\s*$/)
      end
    end

    def matches_is_key_block?(line)
      # Is it a | or > string value?
      line.match(/^(\s*)(["']?[\w\-]+["']?)(: )(\s*)([|>])(\s*)$/)
    end

    def indentation_of(line)
      line.match(/^\s*/)[0] rescue ''
    end

    def break_blocks_into_array
      array = []

      loop do

        maybe_next_line = @read_line_again || @io_input.gets || break
        @read_line_again = nil
        maybe_next_line.chomp!

        next if is_blank?(maybe_next_line)

        key_value_parse = matches_key_value_line?(maybe_next_line)
        if key_value_parse
          array << maybe_next_line.concat(LINE_BREAK) # yes, it is the beginning of a key:value block

          # Special cases when it should add extra lines to the array element (multi line quoted strings)

          starts_with_quote = matches_starts_with_quote?(key_value_parse)
          ends_with_quote = matches_ends_with_quote?(key_value_parse)
          if starts_with_quote and !(starts_with_quote == ends_with_quote)
            append_next_lines_until_closing_quote!(array, starts_with_quote)
          end
          next
        end

        matches_is_key_block = matches_is_key_block?(maybe_next_line)
        if matches_is_key_block
          array << maybe_next_line.concat(LINE_BREAK) # yes, it is the beginning of a key block
          indentation = matches_is_key_block[1]
          # Append the next lines until we find one that is not indented
          loop do
            content_line = @io_input.gets || break
            processed_line = content_line.chomp
            this_indentation = indentation_of(processed_line)
            if indentation.size < this_indentation.size
              array.last << processed_line.concat(LINE_BREAK)
            else
              @read_line_again = content_line
              break
            end
          end

          next
        end #if is_special_string

        # Is it the beginning of a multi level hash?
        is_start_of_hash = maybe_next_line.match(/^(\s*)(["']?[\w\W\-]+["']?)(:)(\s*)$/)
        if is_start_of_hash
          array << maybe_next_line.concat(LINE_BREAK)
          next
        end

        # If we got here and nothing was done, this line
        # should probably be merged with the previous one.
        if array.last
          array.last << maybe_next_line.concat(LINE_BREAK)
        else
          array << maybe_next_line.concat(LINE_BREAK)
        end
      end

      array
    end

    def sorted_yaml_from_blocks_array(current_block = nil)

      unless current_block
        current_block = @array[@current_array_index]
        @current_array_index += 1
      end

      out_array = []
      current_match = current_block.match(/^(\s*)(["']?[\w\W\-]+["']?)(:)/)
      current_level = current_match[1] rescue ''
      current_key = current_match[2].downcase.tr(%q{"'}, "") rescue ''
      out_array << [current_key, current_block]

      loop do
        next_block = @array[@current_array_index] || break
        @current_array_index += 1

        current_match = next_block.match(/^(\s*)(["']?[\w\W\-]+["']?)(:)/) || next
        current_key = current_match[2].downcase.tr(%q{"'}, "")
        next_level = current_match[1]

        if current_level.size < next_level.size
          out_array.last.last << sorted_yaml_from_blocks_array(next_block)
        elsif current_level.size == next_level.size
          out_array << [current_key, next_block]
        elsif current_level.size > next_level.size
          @current_array_index -= 1
          break
        end
      end

      out_array.sort.map(&:last).join
    end
  end
end
