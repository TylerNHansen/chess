require './chess.rb'

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



  def make_move(pos_start,pos_end)
    #throws error if move is invalid
    #moves piece from start to end if it is valid
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
    pieces_copy = pieces.map { |piece| piece.dup }
    turn_copy = self.turn.dup
    board_copy = Board.new(true)
    board_copy.pieces = pieces_copy
    board_copy.turn = turn_copy
    board_copy
  end

  def empty?(pos)
    pos = pos.force_pos

    pieces.none? { |piece| piece.location == pos}
  end

  def has_piece?(pos, color)
    pos = pos.force_pos

    pieces.any? { |piece| piece.location == pos && piece.color == color }
  end

  protected

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