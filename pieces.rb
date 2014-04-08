require './chess.rb'

class Piece
  attr_reader :location, :color, :board

  def initialize(location, color, board)
    @location, @color, @board = Position.new(location), color, board
  end

  def row_col
    [self.location.row, self.location.col]
  end

  def disp_str(string = 'X')
    #returns capital letters for white pieces, lowercase for black
    self.color == 'white' ? string.upcase : string.downcase
  end

  def move(pos)
    #raises error if can't move there
    raise NotImplementedError
  end

  def capture(pos)
    #raises error if can't capture there
    raise NotImplementedError
  end

  def valid_moves
    raise NotImplementedError
  end

  def valid_captures
    raise NotImplementedError
  end
end

class SlidingPiece < Piece
  def clear_path?(target)
    #raise exception if target and current position aren't in a straight line
    # does not check whether target is occupied
  end

  def directions
    raise NotImplementedError
  end

  def valid_moves
    valid_locs = []
    self.directions.each do |direction|
      loop do
        next_in_dir = self.location.next_pos(direction)
        break if next_in_dir.nil?
        break unless board.empty?(next_in_dir)
        valid_locs << next_in_dir
      end
    end
  end

end

class Queen < SlidingPiece

  def disp_str
    super('q')
  end

  def directions
    [[0,1],[0,-1],[1,0],[-1,0],[1,1][1,-1][-1,1],[-1,-1]]
  end

end

class Bishop < SlidingPiece

  def disp_str
    super('b')
  end

  def directions
    [[1,1][1,-1][-1,1],[-1,-1]]
end

class Rook < SlidingPiece

  def disp_str
    super('r')
  end

  def directions
    [[0,1],[0,-1],[1,0],[-1,0]]
  end

end


class SteppingPiece < Piece

  def valid_moves
    valid_locs = []
    self.directions.each do |direction|
      next_in_dir = self.location.next_pos(direction)
      next if next_in_dir.nil?
      next unless board.empty?(next_in_dir)
      valid_locs << next_in_dir
      end
    end
  end

end

class Knight < SteppingPiece

  def disp_str
    super('n')
  end

  def directions
    [[2, 1], [-2, 1],[2, -1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
  end

end

class King < SteppingPiece

  def disp_str
    super('k')
  end

  def directions
    [[0,1],[0,-1],[1,0],[-1,0],[1,1][1,-1][-1,1],[-1,-1]]
  end

end

class Pawn < Piece

  def disp_str
    super('p')
  end

  def valid_moves
    valid_locs = []
    next_pos = self.front_pos
    valid_locs << next_pos if self.board.empty?(next_pos)
    if (self.color == 'white' ? self.location.row == 2 : self.location.row == 7)
      next_pos = self.front_pos(2)
      valid_locs << next_pos if self.board.empty?(next_pos)
    end
    valid_locs
  end

  def front_pos(dist = 1)
    self.color == 'white' ? [self.location.next_pos([dist,0])] :
                            [self.location.next_pos([-dist,0])]
  end

end