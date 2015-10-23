
require 'pry'

class BinaryTree

  attr_accessor :root, :left, :right, :bool

  def initialize(data)
    @root = data
    @left = nil
    @right = nil
  end

  def add_node(data)

    # H = { true => { true => make new node set to left  ,
    #                false => left add_node },
    #      false => { true => make new node set to right ,
    #                false => right add_node }}
    #
    #   H[data < root][data < root ? left.nil? : right.nil?].call

    if left.nil? && data < root
      @left = BinaryTree.new(data)
    elsif right.nil? && data > root
      @right = BinaryTree.new(data)
    elsif data < root
      left.add_node(data)
    elsif data > root
      right.add_node(data)
    end

  end


  def include?(data)
    false
    if data == root
      true
    elsif left.nil? && data < root
      false
    elsif right.nil? && data > root
      false
    elsif data < root
      left.include?(data)
    elsif data > root
      right.include?(data)
    end
  end

  def depth_of(data)
    depth = 0

    if data == root
      depth
    elsif left.nil? && data < root
      depth = "ERROR - data not in tree"
    elsif right.nil? && data > root
      depth = "ERROR - data not in tree"
    elsif data < root
      depth = 1 + left.depth_of(data)
    elsif data > root
      depth = 1 + right.depth_of(data)
    end

    depth

  end

  def maximum
    if right.nil?
      max = root
    else
      max = right.maximum
    end
  end

  def minimum
    if left.nil?
      min = root
    else
      min = left.minimum
    end
  end


  def enumerate
    counter = 0
    if left.nil? && right.nil?
      counter = counter + 1
    elsif left.nil?
      counter = right.enumerate + 1
    elsif right.nil?
      counter = left.enumerate + 1
    else
      counter = left.enumerate + right.enumerate + 1
    end
    counter
  end


end

tree = BinaryTree.new(10)
puts tree.left
puts tree.right
tree.add_node(11)

puts tree.right.root
tree.add_node(12)
tree.add_node(10.5)
puts tree.right.right.root
puts tree.right.left.root
puts tree.include?(10.5)
puts "expect 2 #{tree.depth_of(12)}"
puts tree.inspect
puts tree.maximum
puts tree.enumerate
