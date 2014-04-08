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
end

class Queen < SlidingPiece

  def disp_str
    super('q')
  end

end

class Bishop < SlidingPiece

  def disp_str
    super('b')
  end
end

class Rook < SlidingPiece

  def disp_str
    super('r')
  end

end


class SteppingPiece < Piece

end

class Knight < SteppingPiece

  def disp_str
    super('n')
  end

end

class King < SteppingPiece

  def disp_str
    super('k')
  end

end

class Pawn < Piece

  def disp_str
    super('p')
  end

end