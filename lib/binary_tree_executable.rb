require_relative 'recursive_binary_tree'
require_relative 'file_read_write'

file_manip = FileReaderWriter.new(ARGV[0],ARGV[1])
file_manip.input_output

puts "Created a binary search tree with the entries of '#{ARGV[0]}', sorted them, and printed them in '#{ARGV[1]}' "
