module Players

  # Human class inherits from Player
  class Human < Player

    # Asks the user for input and returns it
    def move(board)
      puts "Please choose a space:"
      user_input = gets.strip
    end
  end
end
