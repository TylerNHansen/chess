# encoding: utf-8

require 'colorize'

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

  WHITE_DISP_COLOR = :white
  BLACK_DISP_COLOR = :black
  WHITE_SQ_COLOR = :red
  BLACK_SQ_COLOR = :green
  CHESS_SYMBS = Hash.new('  ').merge(
  Hash[
    'p' => "\u265F ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'r' => "\u265C ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'b' => "\u265D ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'n' => "\u265E ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'k' => "\u265A ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'q' => "\u265B ".encode('utf-8').colorize(BLACK_DISP_COLOR),
    'P' => "\u2659 ".encode('utf-8').colorize(WHITE_DISP_COLOR),
    'R' => "\u2656 ".encode('utf-8').colorize(WHITE_DISP_COLOR),
    'B' => "\u2657 ".encode('utf-8').colorize(WHITE_DISP_COLOR),
    'N' => "\u2658 ".encode('utf-8').colorize(WHITE_DISP_COLOR),
    'K' => "\u2654 ".encode('utf-8').colorize(WHITE_DISP_COLOR),
    'Q' => "\u2655 ".encode('utf-8').colorize(WHITE_DISP_COLOR)
    ] )

  def initialize(make_blank = false)
    return self if make_blank
    @turn = "white"
    @pieces = []
    populate_board
    self
  end

  def over?
    return false if has_moves?(self.turn)
    puts "GAME OVER"
    true
  end

  def in_check?(player)
    pieces.select { |p| p.color != player }.any? do |starting_piece|
      starting_piece.threatened_pieces.any? do |piece|
        piece.class == King
      end
    end
  end

  def checkmate?(player)
    return false unless in_check?(player)
    return false if has_moves?(player)
    true
  end

  def has_moves?(player)
    self.pieces.each do |piece|
      return true if (piece.color == player && piece.legal_moves.any?)
    end
    false
  end

  def make_move(pos_start,pos_end)

    # pos_start = pos_start.force_pos
    # pos_end = pos_end.force_pos

    unless has_piece?(pos_start, turn)
      raise InvalidMoveError # "You do not have a piece there."
    end

    moving_piece = piece_at(pos_start)
    if moving_piece.legal_moves.include?(pos_end)
      moving_piece.move(pos_end)
    else
      raise InvalidMoveError # "That is not a valid move"
    end

    self.turn == "white" ? self.turn = "black" : self.turn = "white"
    nil
  end

  # MOVES WITHOUT CHECKING IF IT'S VALID OR NOT
  def move(pos_start, pos_end)
    self.pieces.delete_if {|piece| piece.location == pos_end}
    self.piece_at(pos_start).move(pos_end)
    self
  end

  def render
    puts
    disp_board = "        \n" * 8
    pieces.each do |piece|
      row, col = piece.row_col
      index = row * 9 + col
      disp_board[index] = piece.disp_str
    end
    colorize_board(disp_board)
    true
  end

  def deep_dup
    board_copy = Board.new(true)

    board_copy.pieces = self.pieces.map { |piece| piece.dup(board_copy) }
    board_copy.turn = self.turn.dup
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

  def colorize_board(input_board)
    colorized_board = ""
    current_color = WHITE_SQ_COLOR
    to_color = input_board.split('')
    until to_color.empty?
      current_square = to_color.shift
      if current_square == "\n"
        puts
      else
        print CHESS_SYMBS[current_square].colorize( :background => current_color)
      end
      current_color =  (current_color == WHITE_SQ_COLOR ? BLACK_SQ_COLOR : WHITE_SQ_COLOR)
    end
  end

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