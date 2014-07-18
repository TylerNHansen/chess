# encoding: utf-8
load './board.rb'
load './pieces.rb'
load './position.rb'
load './player.rb'
load './stepping_pieces.rb'
load './sliding_pieces.rb'
load './pawn.rb'
require 'colorize'

class Game
  attr_reader :board, :white, :black

  def initialize
    @board = Board.new
    @white = Player.new("Player One")
    @black = Player.new("Player Two")
  end

  def play
    loop do
      play_turn
      break if self.board.over?
    end
    self.board.render
    nil
  end

  private

  def play_turn

    begin
      if self.board.turn == "white"
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

if __FILE__ == $PROGRAM_NAME
  Game.new.play
  nil
end