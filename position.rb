require './chess.rb'

class Position
  attr_reader :row, :col

  def initialize(input_string)
    @row, @col = self.parse(input_string)
    self
  end

  def force_pos
    self #already is a pos, String has a method of same name monkey patched in
  end

  def == (other_pos)
    self.row == other_pos.row && self.col == other_pos.col
  end


  protected

  def parse(string)
    #throw error if first char isn't a-h, second isn't 1-8
    unless string.size == 2
      raise InvalidInputError, 'Invalid input length'
    end

    unless 'abcdefgh'.include?(string[0]) && '12345678'.include?(string[1])
      raise InvalidInputError, 'Not a valid chess board position'
    end


    row = 8 - (string[1].to_i)
    col = string[0].ord - 'a'.ord
    [row,col]
  end

end