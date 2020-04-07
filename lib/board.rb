require 'pry'

class Board

  attr_accessor :cells

  def initialize
    self.reset!
  end

  # Clears the board to beginning of game setup
  def reset!
    @cells = [" ", " ", " ",
      " ", " ", " ",
      " ", " ", " "]
  end

  # Prints the current board
  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  # Takes in user input and returns the value of the board cell
  def position(user_input)
    @cells[user_input.to_i - 1]
  end

  # Returns true for a full board
  def full?
    !@cells.include?(" ")
  end

  # Returns the amount of turns based on cell value
  def turn_count
    @cells.select{|c| c == "X" || c == "O"}.size
  end

  # Returns true if position is X or O
  def taken?(user_position)
    self.position(user_position) == "X" || self.position(user_position) == "O"
  end

  # Returns true for user input between 1-9 that is not taken
  def valid_move?(user_position)
    !self.taken?(user_position) && user_position.to_i >= 1 && user_position.to_i <= 9
  end

  # Updates the cells in the board with the player token
  # according to the input
  def update(position, player)
    @cells[position.to_i - 1] = player.token 
  end

end
