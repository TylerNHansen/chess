class Pawn < Piece

  def disp_str
    super('p')
  end

  def valid_moves
    valid_locs = []
    next_pos = self.front_pos
    valid_locs << next_pos if self.board.empty?(next_pos)
    if (self.color == 'white' ? self.location.row == 6 : self.location.row == 1)
      other_pos = self.front_pos(2)
      valid_locs << other_pos if self.board.empty?(other_pos)
    end

    valid_locs += capture_positions
    valid_locs.compact
  end

  def front_pos(dist = 1)
    self.color == 'white' ? self.location.next_pos([-dist,0]) :
                            self.location.next_pos([dist,0])
  end

  def capture_positions
    right_pos = self.front_pos.next_pos([0,1])
    left_pos = self.front_pos.next_pos([0,-1])
    captures = []
    captures << right_pos if self.has_opp_piece?(right_pos)
    captures << left_pos if self.has_opp_piece?(left_pos)
    captures
  end

end