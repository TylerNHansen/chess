load './board.rb'
load './pieces.rb'
load './position.rb'
load './player.rb'
require 'debugger'

class Game
  attr_reader :board, :white, :black

  def initialize
    @board = Board.new
    @white = Player.new("player 1")
    @black = Player.new("player 2")
  end

  def play

    until self.board.over?
      play_turn
    end
    nil
  end

  # private

  def play_turn
    #asks current player for a move

    begin
      if self.board.turn == white
        start_pos, end_pos = white.get_move(self.board)
      else
        start_pos, end_pos = black.get_move(self.board)
      end

      self.board.make_move(start_pos, end_pos)

    rescue InvalidMoveError => e
      puts "Invalid Move: #{e.message}"
      retry
    rescue InvalidInputError => e
      puts "Invalid Input: input not expected"
      retry
    end


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

game = Game.new
game.play