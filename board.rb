require './chess.rb'
require 'debugger'

class Board
  attr_accessor :pieces, :turn

  STARTING_BOARD = {
    :n => [['b1','white'],['g1', 'white'],['b8','black'],['g8','black']],
    :k => [['e1','white'],['e8','black']],
    :q => [['d1','white'],['d8','black']],
    :b => [['c1','white'],['f1', 'white'],['c8','black'],['f8','black']],
    :p => ['a2','b2','c2','d2','e2','f2','g2','h2'].map { |pos| [pos,'white'] }
    .concat(['a7','b7','c7','d7','e7','f7','g7','h7',].map { |pos| [pos, 'black'] }),
    :r => [['a1','white'],['h1', 'white'],['a8','black'],['h8','black']]
  }

  def initialize(make_blank = false)
    return self if make_blank
    @turn = "white"
    @pieces = []
    populate_board
    self
  end

  def over?
    false #implement later
  end



  def make_move(pos_start,pos_end)

    # pos_start = pos_start.force_pos
    # pos_end = pos_end.force_pos

    unless has_piece?(pos_start, turn)
      raise InvalidMoveError # "You do not have a piece there."
    end

    moving_piece = piece_at(pos_start)
    if moving_piece.valid_moves.include?(pos_end)
      #remove piece of other color at pos_end
      self.pieces.delete_if {|piece| piece.location == pos_end}
      moving_piece.move(pos_end)
    else
      raise InvalidMoveError # "That is not a valid move"
    end

    self.turn == "white" ? self.turn = "black" : self.turn = "white"
    nil
  end

  def render
    #shows the board
    #create what empty board looks like
    #for each piece, replace char at location with display string
    puts
    disp_board = "        \n" * 8
    pieces.each do |piece|
      row, col = piece.row_col
      index = row * 9 + col
      disp_board[index] = piece.disp_str
    end
    puts disp_board
    true
  end

  def deep_dup
    #copied pieces need to refer to copied board
    pieces_copy = pieces.map { |piece| piece.dup }
    turn_copy = self.turn.dup
    board_copy = Board.new(true)
    board_copy.pieces = pieces_copy
    board_copy.turn = turn_copy
    board_copy
  end

  def empty?(pos)
    return false if pos.nil?
    pos = pos.force_pos

    pieces.none? { |piece| piece.location == pos}
  end

  def has_piece?(pos, color)
    return false if pos.nil?
    pos = pos.force_pos

    pieces.any? { |piece| piece.location == pos && piece.color == color }
  end

  protected

  def piece_at(pos)
    pos = pos.force_pos
    raise InvalidMoveError "No piece there!" if self.empty?(pos)
    #find would work here
    pieces.select{ |piece| piece.location == pos}.first
  end

  def populate_board
    STARTING_BOARD[:n].each do |pos_str,color|
      @pieces << Knight.new(pos_str, color, self)
      end
    STARTING_BOARD[:k].each do |pos_str,color|
      @pieces << King.new(pos_str, color, self)
      end
    STARTING_BOARD[:q].each do |pos_str,color|
      @pieces << Queen.new(pos_str, color, self)
      end
    STARTING_BOARD[:b].each do |pos_str,color|
      @pieces << Bishop.new(pos_str, color, self)
      end
    STARTING_BOARD[:p].each do |pos_str,color|
      @pieces << Pawn.new(pos_str, color, self)
      end
    STARTING_BOARD[:r].each do |pos_str,color|
      @pieces << Rook.new(pos_str, color, self)
      end
    nil
  end
end