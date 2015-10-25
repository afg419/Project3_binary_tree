require_relative '../lib/night_writer_2'
require_relative '../lib/night_reader_2'
require 'pry'

class FileReaderWriter

  attr_reader :input, :output

  def initialize (input,output)
    @input = File.open(input,'r')
    @output = File.open(output, 'w')
  end

  def input_output
    tree = BinaryTree.new
    @input.each_line do |entry|
        tree.add_node(entry.to_i)
    end

    sorted_array = tree.sort

    sorted_array.each do |entry|
      @output.write(entry.to_s + "\n")
    end
  end

end
