# encoding: utf-8
load './board.rb'
load './pieces.rb'
load './position.rb'
load './player.rb'
require 'colorize'
require 'debugger'

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
      return nil if self.board.over?
    end
    nil
  end

  # private

  def play_turn
    #asks current player for a move

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

Game.new.play
nil