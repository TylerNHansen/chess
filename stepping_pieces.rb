class SteppingPiece < Piece

  def valid_moves
    valid_locs = []
    self.directions.each do |direction|
      trial_pos = self.location.next_pos(direction)
      next if trial_pos.nil?
      next if board.has_piece?(trial_pos, self.color)
      valid_locs << trial_pos
    end
    valid_locs
  end

end

class Knight < SteppingPiece

  def disp_str
    super('n')
  end

  def directions
    [[2, 1], [-2, 1], [2, -1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
  end

end

class King < SteppingPiece

  def disp_str
    super('k')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1,], [-1,1], [-1,-1]]
  end

end