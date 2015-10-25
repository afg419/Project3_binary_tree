
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

  def test_adds_multiple_values
    tree = BinaryTree.new(10)
    tree.add_many_nodes([15,-1,6,9,12])

    assert_equal 6,  tree.left.right.root
    assert_equal 12, tree.right.left.root
  end

  def test_can_detect_values_in_small_tree
    tree = BinaryTree.new(10)
    tree.add_node(15)
    assert tree.include?(15)
    tree.add_node(2)

    assert tree.include?(2)
  end

  def test_can_detect_absence_of_values_in_small_tree
    tree = BinaryTree.new(10)
    tree.add_node(15)
    refute tree.include?(9)
    tree.add_node(2)

    refute tree.include?(3)
  end

  def test_can_detect_value_in_medium_tree
    tree = BinaryTree.new(10)
    inputs = [11,9,4,12,5,14,13]
    tree.add_many_nodes(inputs)

    assert tree.include?(14)
    refute tree.include?(1)
  end

  def test_can_detect_random_values_in_massive_tree
    tree = BinaryTree.new(500)
    library = (0..1000).to_a.shuffle
    library.delete(500)
    inputs = library[0..500]
    test_val = library.sample
    tree.add_many_nodes(inputs)

    assert_equal inputs.include?(test_val) , tree.include?(test_val)
  end

  def test_can_determine_depth_of_a_value_medium_tree
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    tree.add_many_nodes(inputs)

    assert_equal 0, tree.depth_of(0)
    assert_equal 3, tree.depth_of(-12)
    assert_equal 6, tree.depth_of(10)
  end

  def test_can_determine_maximum_value_in_small_tree
    tree = BinaryTree.new(10)
    tree.add_many_nodes([15,9,16,3])

    assert_equal 16, tree.maximum
  end


  def test_can_determine_maximum_value
    library = (0..1000).to_a.shuffle
    library.delete(500)
    inputs = library[0..500]
    tree = BinaryTree.new(500)
    tree.add_many_nodes(inputs)

    assert_equal inputs.max, tree.maximum

  end

  def test_can_determine_minimum_value
    library = (0..1000).to_a.shuffle
    library.delete(500)
    inputs = library[0..500]
    tree = BinaryTree.new(500)
    tree.add_many_nodes(inputs)

    assert_equal inputs.min, tree.minimum
  end

  def test_can_sort_entries_medium_tree
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    tree.add_many_nodes(inputs)

    assert_equal (inputs+[0]).sort, tree.sort
  end

  def test_can_sort_entries
    library = (0..1000).to_a.shuffle
    library.delete(500)
    inputs = library[0..500]
    tree = BinaryTree.new(500)
    tree.add_many_nodes(inputs)

    assert_equal (inputs+[500]).sort , tree.sort
  end

  def test_can_count_nodes_medium_tree
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    tree.add_many_nodes(inputs)

    assert_equal (inputs+[0]).length, tree.enumerate
  end

  def test_can_count_nodes
    library = (0..1000).to_a.shuffle
    library.delete(500)
    num = library.sample
    inputs = library[0..num]
    tree = BinaryTree.new(500)
    tree.add_many_nodes(inputs)

    assert_equal num+2, tree.enumerate #+2 , one for 0, one for 500
  end

  def test_can_count_leaves_small_tree
    tree = BinaryTree.new(10)
    tree.add_node(15)
    assert tree.include?(15)
    tree.add_node(2)

    assert_equal 2, tree.leaf_count
  end

  def test_can_count_leaves_medium_tree
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    tree.add_many_nodes(inputs)

    assert_equal 5, tree.leaf_count
  end

  def test_can_determine_max_branch_length_small_tree
    tree = BinaryTree.new(10)
    tree.add_node(15)
    assert tree.include?(15)
    tree.add_node(2)

    assert_equal 2, tree.leaf_count
  end


  def test_can_determine_max_branch_length_medium_tree
    tree = BinaryTree.new(0)
    inputs = [12,-1,-8,4,5,3,-2,8,7,-3,2,-12,11,10]
    tree.add_many_nodes(inputs)

    assert_equal 6, tree.max_branch_depth
  end


end
