# encoding: utf-8
# require './chess.rb'

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move(board)
    board.render
    puts "#{self.name}, please enter your move like 'E4,E5'"
    gets.chomp.split(',')
  end

end
