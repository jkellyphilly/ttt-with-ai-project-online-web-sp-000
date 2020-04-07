module Players

  # Inherits from the Player class
  class Computer < Player

    # Given the current board, implement a method for the
    # computer to choose a position
    def move(board)
      puts "Calculating best result with my computer brain..."

      return_val = "0"
      other_player = self.token == "X" ? "O" : "X"
      return_val_updated = false

      # First, check to see if it's the first move of the game.
      # If so, move to the middle (which is "5")
      if board.turn_count == 0
        return_val = "5"

      # If there's been one move, move to the upper corner.
      elsif board.turn_count == 1
        if !board.taken?("5")
          return_val = "5"
        elsif !board.taken?("1")
          return_val = "1"
        end

      # If there's been two moves, that means I started as X so the middle is taken.
      # Find where that O is and move strategically according to that.
      elsif board.turn_count == 2
        #binding.pry
        occupied_space = board.cells.index("O")
        case occupied_space
        when 0
          return_val = "3"
        when 1
          return_val = "1"
        when 2
          return_val = "1"
        when 3
          return_val = "1"
        when 5
          return_val = "3"
        when 6
          return_val = "1"
        when 7
          return_val = "6"
        when 8
          return_val = "3"
        end
      else

        # Otherwise, the game has started. Check to see if I can
        # possibly win.
        Game::WIN_COMBINATIONS.each do |combo|
          win_1, win_2, win_3 = combo
          win_1_string = (win_1 + 1).to_s
          win_2_string = (win_2 + 1).to_s
          win_3_string = (win_3 + 1).to_s
          # Check to see if I occupy each space and if moving into
          # one of the remaining spaces gets me victory
          if board.cells[win_1] == self.token
            if board.cells[win_2] == self.token && !board.taken?(win_3_string)
              return_val = win_3_string
              return_val_updated = true
            elsif board.cells[win_3] == self.token && !board.taken?(win_2_string)
              return_val = win_2_string
              return_val_updated = true
            end
          elsif board.cells[win_2] == self.token
            if board.cells[win_3] == self.token && !board.taken?(win_1_string)
              return_val = win_1_string
              return_val_updated = true
            end
          end
        end # Ending the check for my winning possibilities

        # Well... looks like I can't win. Time to make sure
        # that I block any of the opponents' attempts to win.
        # Also need to make sure that the return val hasn't been updated.
        if !return_val_updated
          Game::WIN_COMBINATIONS.each do |combo|
            win_1, win_2, win_3 = combo
            win_1_string = (win_1 + 1).to_s
            win_2_string = (win_2 + 1).to_s
            win_3_string = (win_3 + 1).to_s
            # Check to see if I occupy each space and if moving into
            # one of the remaining spaces gets me victory
            if board.cells[win_1] == other_player
              if board.cells[win_2] == other_player && !board.taken?(win_3_string)
                return_val = win_3_string
                return_val_updated = true
              elsif board.cells[win_3] == other_player && !board.taken?(win_2_string)
                return_val = win_2_string
                return_val_updated = true
              end
            elsif board.cells[win_2] == other_player
              if board.cells[win_3] == other_player && !board.taken?(win_1_string)
                return_val = win_1_string
                return_val_updated = true
              end
            end
          end # ending the loop through WIN_COMBINATIONS
        end # ending the check to see IF my opponent can win

        # At this point, just choose the first available spot.
        # Still need to make sure the return val hasn't been updated.
        if !return_val_updated
          board.cells.each_with_index do |cell, index|
            input = (index + 1).to_s
            if !board.taken?(input) && !return_val_updated
              return_val =  input
              return_val_updated = true
            end
          end
        end
      end # if/elsif/else tree end

      sleep(2)
      return_val
    end # Move method end

  end # Class end
end # Module end
