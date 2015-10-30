require_relative "00_tree_node"

class KnightPathFinder

  def initialize(start_coordinates)
      @visited_positions = [start_coordinates]
      @start_position = start_coordinates

  end

  def find_path(target)
    path = []
    tree = build_move_tree(target)
    end_node = tree[target]
    path << end_node.value

    until path.include?(@start_position)
      path << end_node.parent.value
      end_node = end_node.parent
    end
    path.reverse
  end

  def self.valid_moves(pos)
    # tells me everywhere I can move from given position in one move by:
    #   check all generated moves within_bounds?(generated_move)
    #   give back all generated moves that are within bounds
    generated_moves = []
    8.times do |i|
      case i
      when 0
        move = [pos[0] + 2, pos[1] + 1]
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 1
        move = [pos[0] + 2, pos[1] - 1]
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 2
        move = [pos[0] - 2, pos[1] + 1]
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 3
        move = [pos[0] - 2, pos[1] - 1]
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 4
        move = [pos[1] + 2, pos[0] + 1].reverse
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 5
        move = [pos[1] + 2, pos[0] - 1].reverse
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 6
        move = [pos[1] - 2, pos[0] + 1].reverse
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      when 7
        move = [pos[1] - 2, pos[0] - 1].reverse
        generated_moves << move if KnightPathFinder.within_bounds?(move)
      end
    end
    generated_moves
  end

  def self.within_bounds?(move)
    if move[0] < 0 || move[0] > 7
      false
    elsif move[1] < 0 || move[1] > 7
      false
    else
      true
    end
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos)
  end

  def build_move_tree(target)
    root = PolyTreeNode.new(@start_position)
    tree_node_container = {@start_position => root}

    next_moves = new_move_positions(@start_position)
    queue_of_moves = next_moves.dup
    @visited_positions.concat(next_moves)

    next_moves.each do |move|
      a_move_node = PolyTreeNode.new(move)
      a_move_node.parent = root
      tree_node_container[move] = a_move_node
    end

    until @visited_positions.include?(target)
      eval_position = queue_of_moves.shift
      next_moves = new_move_positions(eval_position)
      next_moves.reject! {|move| @visited_positions.include?(move) }

      next_moves.each do |move|
        a_move_node = PolyTreeNode.new(move)
        a_move_node.parent = tree_node_container[eval_position]
        tree_node_container[move] = a_move_node
      end

      @visited_positions.concat(next_moves)
      queue_of_moves.concat(next_moves)
    end

    tree_node_container
  end

end
