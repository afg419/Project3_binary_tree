
require 'pry'

class BinaryTree

  attr_accessor :root, :left, :right

  def initialize(data)
    @root = data
    @left = nil
    @right = nil
  end

  def bi_conditional_executable(a_bool,a_true_b1_bool,a_false_b2_bool, lambda_aTb1T, lambda_aFb1T, lambda_aFb2T, lambda_aFb2F)

    executor = { true => { true => lambda_aTb1T ,
                          false => lambda_aFb1T},
                false => { true => lambda_aFb2T ,
                          false => lambda_aFb2F } }

    executor[a_bool][a_bool ? a_true_b1_bool : a_false_b2_bool].call

  end

  def add_node(data)

      l1 = lambda {@left = BinaryTree.new(data)}
      l2 = lambda {@right = BinaryTree.new(data)}
      l3 = lambda {left.add_node(data)}
      l4 = lambda {right.add_node(data)}

    bi_conditional_executable(data < root, left.nil?, right.nil?, l1,l3,l2,l4)

    #
    # if left.nil? && data < root
    #   @left = BinaryTree.new(data)
    # elsif right.nil? && data > root
    #   @right = BinaryTree.new(data)
    # elsif data < root
    #   left.add_node(data)
    # elsif data > root
    #   right.add_node(data)
    # end

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


  def delete_beneath_and_regen(new_tree,marker)
    if !left.nil? && !left.root.nil?
      new_tree.add_node(left.delete_beneath_and_regen(new_tree,marker))
    end

    if !right.nil? && !right.root.nil?
      new_tree.add_node(right.delete_beneath_and_regen(new_tree,marker))
    end

    if root == marker
      new_tree
    elsif (left.nil? || left.root.nil?) && (right.nil? || right.root.nil?)
      temp = root
      @root = nil
      temp
    end

  end

  def delete(value)
    if !@right.nil? && @right.root == value
      @right = delete_beneath_and_regen(BinaryTree.new(@right.root),root)
    elsif !@left.nil? && left.root == value
      @left = delete_beneath_and_regen(BinaryTree.new(@left.root),root)
    elsif !@right.nil? && value > root
      @right.delete(value)
    elsif !@left.nil? && value < root
      @left.delete(value)
    end
  end

  # def delete(value)
  #
  #   found_value = false
  #
  #     if root == value
  #       found_value = true
  #     end
  #
  #     binding.pry
  #
  #     if !found_value
  #       if value < root && !left.nil?
  #         left.delete(value)
  #       elsif value > root && !right.nil?
  #         right.delete(value)
  #       elsif root == value
  #         found_value = true
  #       end
  #     end
  #
  #     if found_value
  #       delete_beneath_and_regen
  #     end
  #
  #
  #
  # end



end

tree = BinaryTree.new(10)
tree.add_many_nodes([15,12,6,8,4,13,11])

key = tree.delete(13)
p key
