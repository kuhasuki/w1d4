class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    if @parent == nil #I dont have a parent
      @parent = parent #update my current parent
      parent.children << self if parent #add me to new parents children

    elsif parent == nil #you give me a nil parent
      if @parent
        @parent.children.delete(self) #remove me from old parents children
        @parent = nil #remove my current parent
      end

    elsif valid_node?(parent) #you give me a new parent
      @parent.children.delete(self) #remove me from old parents children
      @parent = parent #update my current parent
      parent.children << self #add me to new parents children

    else #you give me a bad parent
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
