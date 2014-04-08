require 'rspec'
require './chess.rb'
require './board.rb'


describe "Position#initialize" do
  # Position class parses 2-char strings as chess positions, and converts
  # to and from 2d array indices

  it "makes a 'a8' position with row, col == 0,0" do
    expect(Position.new("a8").row).to eq(0)
    expect(Position.new("a8").col).to eq(0)
  end

  it "makes a 'e5' position with row, col == 3,4" do
    expect(Position.new("e5").row).to eq(3)
    expect(Position.new("e5").col).to eq(4)
  end

  it "successfully raises error for invalid string input" do
    expect { Position.new("whaat")}.to raise_error
    expect { Position.new("a9") }.to raise_error
    expect { Position.new("z5") }.to raise_error
  end

  it "same positions should be equal" do
    expect (Position.new('a8') == Position.new('a8'))
  end

  it "different positions should not be the same" do
    expect !(Position.new('a5') == Position.new('a8'))
  end
 end

 describe "Board successfully initializes" do
   #Makes a board with the starting 32 pieces

   it "makes 32 pieces" do
     expect(Board.new.pieces.size).to eq(32)
   end

   it "says a1 is not empty and a4 is empty" do
     expect(Board.new.empty?('a1')).to eq(false)
     expect(Board.new.empty?('a4')).to eq(true)
   end

   it "puts a black piece on a8" do
     expect(Board.new.has_piece?("a8", "black"))
   end

   it "raises errors on an invalid move" do
     expect { Board.new.empty?('z5') }.to raise_error
   end

   it "deep dup copies contents" do
     board1 = Board.new
     board2 = board1.deep_dup
     expect(board1.object_id != board2.object_id)
     expect(board1.pieces.object_id != board2.pieces.object_id)
     expect(board1.pieces.first.object_id != board2.pieces.first.object_id)
   end

   it "prints out a board" do
     expect (Board.new.render)
   end

end


