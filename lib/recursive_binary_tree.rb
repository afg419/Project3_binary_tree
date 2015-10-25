
require 'pry'

class BinaryTree

  attr_accessor :root, :left, :right, :reader, :head

  def initialize(data = nil)
    @root = data
    @left = nil
    @right = nil
    @reader = self
  end

  def bi_conditional_executable(a_bool,a_true_b1_bool,a_false_b2_bool, lambda_aTb1T, lambda_aFb1T, lambda_aFb2T, lambda_aFb2F)

    executor = { true => { true => lambda_aTb1T ,
                          false => lambda_aFb1T},
                false => { true => lambda_aFb2T ,
                          false => lambda_aFb2F } }

    executor[a_bool][a_bool ? a_true_b1_bool : a_false_b2_bool].call

  end

  def add_node(data)

    #   l1 = lambda {@left = BinaryTree.new(data)}
    #   l2 = lambda {@right = BinaryTree.new(data)}
    #   l3 = lambda {left.add_node(data)}
    #   l4 = lambda {right.add_node(data)}
    #
    # bi_conditional_executable(data < root, left.nil?, right.nil?, l1,l3,l2,l4)

    if root.nil?
      @root = data
    elsif left.nil? && data < root
      @left = BinaryTree.new(data)
    elsif right.nil? && data > root
      @right = BinaryTree.new(data)
    elsif data < root
      left.add_node(data)
    elsif data > root
      right.add_node(data)
    end

  end


  def add_many_nodes(data_array)
    data_array.each do |datum|
      add_node(datum)
    end
  end


  def include?(data)
    false
    if data < root && !left.nil?
      left.include?(data)
    elsif data > root && !right.nil?
      right.include?(data)
    else
      data == root
    end
  end

  def depth_of(data)
    depth = 0

    if left.nil? && data < root || right.nil? && data > root
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
      counter += 1
    elsif left.nil?
      counter = right.enumerate + 1
    elsif right.nil?
      counter = left.enumerate + 1
    else
      counter = left.enumerate + right.enumerate + 1
    end
    counter
  end

  def sort
    if left.nil? && right.nil?
      [root]
    elsif left.nil?
      [root] + right.sort
    elsif right.nil?
      left.sort + [root]
    else
      left.sort + [root] + right.sort
    end
  end

  def leaf_count
    count = 0
    if left.nil? && right.nil?
      count = 1
    elsif left.nil?
      count = right.leaf_count
    elsif right.nil?
      count = left.leaf_count
    else
      count = left.leaf_count + right.leaf_count
    end
    count
  end

  def max_branch_depth
    depth = 0
    if left.nil? && right.nil?
      depth
    elsif right.nil?
      depth = left.max_branch_depth + 1
    elsif left.nil?
      depth = right.max_branch_depth + 1
    else
      depth = [left.max_branch_depth,right.max_branch_depth].max + 1
    end
  end

#####The following are used to delete a value from a tree and regenerate the tree#######################

  # This method takes a tree and adds all its entries to new_tree, leaving behind just its root

  def destructive_merge_with_new_tree(new_tree,marker)
    if !left.nil? && !left.root.nil?
      new_tree.add_node(left.destructive_merge_with_new_tree(new_tree,marker))
      @left = nil
    end

    if !right.nil? && !right.root.nil?
      new_tree.add_node(right.destructive_merge_with_new_tree(new_tree,marker))
      @right = nil
    end

    if root == marker
      new_tree
    elsif (left.nil? || left.root.nil?) && (right.nil? || right.root.nil?)
      root
    end

  end

  # This method uses iterative methods to find value, then calls the above to delete
  # all entries beneath the value and returns them in a new_tree.  It also kills the
  # value with '@left = nil' or '@right = nil'

  def remove_beneath(value)

    new_tree = nil

    loop do

      if !reader.left.nil? && reader.left.root == value
        new_tree = @reader.left.destructive_merge_with_new_tree(BinaryTree.new(value),value)
        reader.left = nil
        break
      elsif !reader.right.nil? && reader.right.root == value
        new_tree = @reader.right.destructive_merge_with_new_tree(BinaryTree.new(value),value)
        reader.right = nil
        break
      elsif value < reader.root
        @reader = reader.left
      elsif value > reader.root
        @reader = reader.right
      end
    end
    new_tree
  end

  #finally, we take all the values we removed with the previous method, and merge it
  # back with the original tree.

  def delete_and_regen(value)

    if root == value
      tree = destructive_merge_with_new_tree(BinaryTree.new,value)
    else
      new_tree = remove_beneath(value)
      tree = new_tree.destructive_merge_with_new_tree(self,value)
    end
    tree
  end

end





# tree = BinaryTree.new(10)
# tree.add_many_nodes([1,4,2,11,3,14])
#
# new_tree = tree.remove_beneath(2)
# p tree.sort
# p new_tree.sort
#
# p new_tree.destructive_merge_with_new_tree(tree,2)
#
# p new_tree.sort
# p tree.sort
# p tree.root
