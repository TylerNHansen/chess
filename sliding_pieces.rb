class SlidingPiece < Piece

  def directions
    raise NotImplementedError
  end

  def valid_moves
    valid_locs = []

    self.directions.each do |direction|
      current_pos = self.location.next_pos(direction)
      loop do
        break if board.has_piece?(current_pos, self.color)
        break if current_pos.nil?
        valid_locs << current_pos
        break unless board.empty?(current_pos) #has piece of the other color
        current_pos = current_pos.next_pos(direction)
      end
    end
    valid_locs
  end

end

class Queen < SlidingPiece

  def disp_str
    super('q')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

end

class Bishop < SlidingPiece

  def disp_str
    super('b')
  end

  def directions
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end
end

class Rook < SlidingPiece

  def disp_str
    super('r')
  end

  def directions
    [[0,1], [0,-1], [1,0], [-1,0]]
  end

end