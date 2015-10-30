class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(given_parent)

    # If I have no parent and the given parent is good
    if @parent == nil && valid_node?(given_parent)
      @parent = given_parent
      given_parent.children << self

    # If you want to remove my parent
    elsif given_parent == nil
      if @parent
        @parent.children.delete(self)
        @parent = nil
      end

    #If you want to transfer custody to stepdad
    elsif valid_node?(given_parent)
      @parent.children.delete(self)
      @parent = given_parent
      given_parent.children << self

    #If parent_given doesn't conform to expectations
    else
      raise "You gave me a bad parent! :("
    end

  end

  def valid_node?(node)
    node.is_a?(PolyTreeNode)
  end


  # When rspec gives incomprehensible output, do this
  def inspect
    { val: @value }.inspect
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if self.children.include?(child)
      child.parent = nil
    else
      raise "That's no child!"
    end
  end

  def is_leaf?
    @children.empty?
  end

  def dfs(target_value)
    return self if self.value == target_value
    if is_leaf?
      return false
    else
      @children.each do |child|
        child_response = child.dfs(target_value)
        if child_response
          return child_response
        end
      end
    nil
    end
  end

  def bfs(target_value)
    queue_of_candidates = []
    return self if self.value == target_value
    queue_of_candidates.concat(@children)
    until queue_of_candidates.empty?
      candidate = queue_of_candidates.shift
      return candidate if candidate.value == target_value
      queue_of_candidates.concat(candidate.children) unless candidate.is_leaf?
    end
  end

end

# a = PolyTreeNode.new('root')
# b = PolyTreeNode.new('child1')
# c = PolyTreeNode.new('child2')
