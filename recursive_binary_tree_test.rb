
require 'minitest'
require 'pry'
require_relative 'recursive_binary_tree'

class BinaryTreeTest < Minitest::Test

  attr_reader :test_tree, :inputs

  def setup
    @test_tree = BinaryTree.new(0)
    @inputs = (0..1000).to_a.shuffle
  end

  def test_class_exists
    assert BinaryTree
  end

  def test_can_initialize_with_data_in_root
    tree = BinaryTree.new(10)
    assert_equal 10, tree.root
  end

  def test_initializes_with_no_other_trees
    tree = BinaryTree.new(15)
    assert tree.left.nil?
    assert tree.right.nil?
  end

  def test_adds_a_tree_to_right
    tree = BinaryTree.new(10)
    tree.add_node(11)
    assert_equal 11 , tree.right.root
  end

  def test_adds_a_tree_to_left
    tree = BinaryTree.new(10)
    tree.add_node(9)
    assert_equal 9 , tree.left.root
  end

  def test_adds_a_tree_right_and_left
    tree = BinaryTree.new(10)
    tree.add_node(9)
    tree.add_node(11)
    assert_equal 9, tree.left.root
    assert_equal 11, tree.right.root
  end

  def test_adds_a_tree_right_right
    tree = BinaryTree.new(10)
    tree.add_node(11)
    tree.add_node(12)
    assert_equal 11, tree.right.root
    assert_equal 12, tree.right.right.root
  end


  def test_adds_a_tree_right_left
    tree = BinaryTree.new(10)
    tree.add_node(12)
    tree.add_node(11)
    assert_equal 12, tree.right.root
    assert_equal 11, tree.right.left.root
  end

  def test_can_detect_value_in_tree
    tree = BinaryTree.new(10)
    inputs = [11,9,4,12,5,14,13]
    inputs.each do |input|
      tree.add_node(input)
    end

    assert tree.include?(14)
    refute tree.include?(1)

  end

  def test_can_detect_random_values_in_tree
    tree = BinaryTree.new(500)
    library = (0..1000).to_a.shuffle
    library.delete(500)
    inputs = library[0..500]
    test_val = library.sample

    inputs.each do |input|
      tree.add_node(input)
    end
    puts "#{inputs.include?(test_val)}"
    assert_equal inputs.include?(test_val) , tree.include?(test_val)
  end

  def test_can_determine_depth_of_a_value
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    inputs.each do |input|
      tree.add_node(input)
    end

    assert_equal 6, tree.depth_of(10)
  end




end