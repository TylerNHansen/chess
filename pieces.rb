class Piece
  attr_reader :location, :color, :board
  attr_writer :location

  def initialize(location, color, board)
    @location, @color, @board = Position.new(location), color, board
  end

  def dup(board)
    self.class.new(self.location, self.color, board)
  end

  def row_col
    @location = @location.force_pos
    [self.location.row, self.location.col]
  end

  def disp_str(string = 'X')
    self.color == 'white' ? string.upcase : string.downcase
  end

  def move(pos)
    pos = pos.force_pos
    self.location = pos
  end

  def threatened_pieces
    # returns pieces of opponent's color that have a location in our valid moves
    opp_pieces = self.board.pieces.select { |piece| piece.color != self.color }
    moves = self.valid_moves
    opp_pieces.select do |piece|
      moves.include?(piece.location)
    end
  end

  # moves that are syntatically valid, not sliding through pieces, not occupied
  # by own color, etc
  # DOES NOT check if a puts you into check
  def valid_moves
    raise NotImplementedError
  end

  def legal_moves
    valid_positions = self.valid_moves
    #for each valid move, check if it puts you in check
    valid_positions.reject do |target|
      self.board.deep_dup.move(self.location, target).in_check?(self.color)
    end
  end

  def inspect
    #overwrite to avoid loops
    "#{self.class} at #{self.location}"
  end

  def has_opp_piece?(pos)
    return false if self.board.empty?(pos)
    return false if self.board.has_piece?(pos, self.color)
    true
  end

end