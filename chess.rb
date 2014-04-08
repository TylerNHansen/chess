class Game
  attr_reader :board, :white, :black

  def initialize
    @board = Board.new
  end

  def play
    #plays the game
  end

  private

  def play_turn
    #asks current player for a move
    #tells board to make that move
    #catches error and retries if move isn't legal
  end

end

class Board
  attr_reader :pieces, :turn

  def initialize
    #initalizes to blank board
  end

  def make_move(pos_start,pos_end)
    #throws error if move is invalid
    #moves piece from start to end if it is valid
  end

  def render
    #shows the board
  end

  def deep_dup
    # deep dupes
  end

  def empty?(pos)
    #returns true unless a piece is at that position
    #raise error if position is not inside chessboard
  end

  def has_piece?(pos, color)
    #returns true if it has a piece of that color
    #else returns false
    #raise error if position not inside chessboard
  end
end

class Piece
  attr_reader :location, :color, :board

  def initialize(location, color, board)
    @location, @color, @board = location, color, board
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
end

class Queen < SlidingPiece
end

class Bishop < SlidingPiece
end

class Rook < SlidingPiece
end


class SteppingPiece < Piece
end

class Knight < SteppingPiece
end

class King < SteppingPiece
end

class Pawn < Piece
end

class Player
end