require 'pry'

class Game

  attr_accessor :board, :player_1, :player_2

  # Define the WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0, 1, 2], # top row
    [3, 4, 5], # middle row
    [6, 7, 8], # bottom row
    [0, 3, 6], # left column
    [1, 4, 7], # middle column
    [2, 5, 8], # right column
    [6, 4, 2], # / diagonal
    [0, 4, 8] # \ diagonal
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    #binding.pry
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    #binding.pry
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    #binding.pry
    WIN_COMBINATIONS.each do |combo|
      win_1, win_2, win_3 = combo
      #binding.pry
      if @board.cells[win_1] == @board.cells[win_2] && @board.cells[win_2] == @board.cells[win_3] && @board.taken?((win_1 + 1).to_s)
        #binding.pry
        return combo
      end
      #binding.pry
    end
    false
  end

  def draw?
    @board.full? && !self.won?
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    if self.won?
      @board.cells[self.won?[0]]
    end
  end

  def turn
    # Delete this after you're done
    @board.display

    input = self.current_player.move(@board)

    # If it's a valid move, then update the board
    # with the current player's token
    if @board.valid_move?(input)
      @board.update(input, self.current_player)
    else
      puts "Not a valid input."
      self.turn
    end
  end

  def play

    until self.over?
      self.turn
    end

    if self.won?
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    end

  end

end
