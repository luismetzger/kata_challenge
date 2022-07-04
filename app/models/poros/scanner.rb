module Poros
  class Scanner
    attr_accessor :scanned_file

    def initialize(scanned_file)
      @scanned_file = scanned_file
    end

    def read
      file = File.read(scanned_file)
      encoded_numbers = file.lines.each_slice(4).take(4)
      lines = []

      # Ex: [[x, x, x, x]]
      encoded_numbers.each do |line_element|
        # Ex: [x, x, x, x]
        line_element.each do |element|
          # splits every 3 characters and
          # removes new line spacing.
          split_numbers =  element.scan(/.../)

          lines << split_numbers unless split_numbers.empty?
        end
      end

      decode_each_line(lines[0], lines[1], lines[2])
    end

    private

    def char_map
      {
        0 => [' _ ','| |','|_|'],
        1 => ['  |','  |','  |'],
        2 => [' _ ',' _|','|_ '],
        3 => [' _ ',' _|',' _|'],
        4 => ['| |','|_|','  |'],
        5 => [' _ ','|_ ',' _|'],
        6 => [' _ ','|_ ','|_|'],
        7 => [' _ ','  |','  |'],
        8 => [' _ ','|_|','|_|'],
        9 => [' _ ','|_|',' _|'],
      }
    end

    def decode_each_line(line0, line1, line2)
      decoded_numbers = []
      (0..8).each { |n| decoded_numbers << map_lines([line0[n], line1[n], line2[n]]) }
      res = if decoded_numbers.all? { |n| n.is_a?(Integer) }
              decoded_numbers.join(",").gsub(",", "")
            else
              error_handling(decoded_numbers)
            end

      File.write("#{scanned_file}_output.txt", res)
    end

    def map_lines(arr)
      # returns a mapped digit or '?'
      char_map.key(arr) || '?'
    end

    def error_handling(msg)
      "Decoded Message: #{msg} - Something is wrong."
    end

    # TODO: Old way of doing the decoding
    # def valid_characters
    #   [' ', ' _ ', '| |', '|_|', '  |', '|  ', '|_ ', ' _|']
    # end
    #
    # def valid?(arr)
    #   arr.each_with_index do |el, index|
    #
    #     if valid_characters.include?(el)
    #       el
    #     else
    #       arr[index] = '?'
    #     end
    #   end
    # end

  end
end
