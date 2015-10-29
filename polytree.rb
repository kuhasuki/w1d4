class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    @parent = parent
    parent.add_child(self)
  end

  def add_child(child)
    @children << child
  end
end
