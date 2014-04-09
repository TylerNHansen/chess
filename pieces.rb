require './chess.rb'
require 'debugger'

class Piece
  attr_reader :location, :color, :board
  attr_writer :location

  def initialize(location, color, board)
    @location, @color, @board = Position.new(location), color, board
  end

  def row_col
    @location = @location.force_pos
    [self.location.row, self.location.col]
  end

  def disp_str(string = 'X')
    #returns capital letters for white pieces, lowercase for black
    self.color == 'white' ? string.upcase : string.downcase
  end

  def move(pos)
    #check if target is a valid move
    # throw and error if it isn't
    # if it's valid, set our position to that square
    #self.valid_moves.include?(pos)
    pos = pos.force_pos
    self.location = pos
  end

  def capture(pos)
    #raises error if can't capture there
    raise NotImplementedError
  end

  def threatened_pieces

  end

  def valid_moves
    raise NotImplementedError
  end

  def valid_captures
    raise NotImplementedError
  end

  def inspect
    #overwrite to avoid loops
    self.class
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
      current_pos = self.location.next_pos(direction)
      loop do
        #instead of checking for empty, check if position has piece of
        #current piece's color
        break if board.has_piece?(current_pos, self.color)
        break if current_pos.nil?
        valid_locs << current_pos
        break unless board.empty?(current_pos) #has piece of the other color
        current_pos = current_pos.next_pos(direction)
      end
    end
    valid_locs
  end

end

class Queen < SlidingPiece

  def disp_str
    super('q')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

end

class Bishop < SlidingPiece

  def disp_str
    super('b')
  end

  def directions
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end
end

class Rook < SlidingPiece

  def disp_str
    super('r')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0]]
  end

end


class SteppingPiece < Piece

  def valid_moves
    valid_locs = []
    self.directions.each do |direction|
      trial_pos = self.location.next_pos(direction)
      next if trial_pos.nil?
      next if board.has_piece?(trial_pos, self.color)
      valid_locs << trial_pos
    end
    valid_locs
  end



end

class Knight < SteppingPiece

  def disp_str
    super('n')
  end

  def directions
    [[2, 1], [-2, 1], [2, -1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
  end

end

class King < SteppingPiece

  def disp_str
    super('k')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1,], [-1,1], [-1,-1]]
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
      other_pos = self.front_pos(2)
      valid_locs << next_pos if self.board.empty?(other_pos)
    end
    valid_locs
  end

  def front_pos(dist = 1)
    self.color == 'white' ? self.location.next_pos([-dist,0]) :
                            self.location.next_pos([dist,0])
  end

end