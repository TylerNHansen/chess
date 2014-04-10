class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move(board)
    board.render
    if board.in_check?('white') || board.in_check?('black')
      puts "You are in check!"
    end
    puts "#{self.name}, please enter your move like 'E4,E5'"
    gets.chomp.split(',')
  end

end
