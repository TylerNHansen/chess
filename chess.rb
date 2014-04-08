require './board.rb'
require './pieces.rb'
require './position.rb'

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

class InvalidMoveError < RuntimeError
end

class InvalidInputError < RuntimeError
end





class String

  def force_pos
    Position.new(self)
  end
end