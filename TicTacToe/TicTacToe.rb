class Board
  
  def initialize
    @board_arr = [
              [], [], [],
              [], [], [],
              [], [], []
              ] 
  end
  
  def board_arr
    @board_arr
  end
  
  def won?
    flag = false
    possible_wins = []
    possible_wins << [board_arr[0], board_arr[1], board_arr[2]] 
    possible_wins << [board_arr[3], board_arr[4], board_arr[5]] 
    possible_wins << [board_arr[6], board_arr[7], board_arr[8]]
    possible_wins << [board_arr[0], board_arr[4], board_arr[8]]
    possible_wins << [board_arr[2], board_arr[4], board_arr[6]]
    possible_wins << [board_arr[2], board_arr[5], board_arr[8]]
    possible_wins << [board_arr[0], board_arr[3], board_arr[6]]
    possible_wins.any? { |combo| combo == [" X", " X", " X"] || combo == [" O", " O", " O"] }
  end
  
  def winner(current_mark)
    puts "#{current_mark.to_s} is the winner!"
    
  end
  
  def empty?(pos)
    board_arr[pos] == []
    #board_arr[pos].empty?
  end
  
  def place_mark(pos, mark)
    board_arr[pos] = " #{mark.to_s}"
  end
  
  def display
    puts "#{board_arr[0]}" + " | " + "#{board_arr[1]}" + " | " + "#{board_arr[2]}"
    puts "------------"
    puts "#{board_arr[3]}" + " | " + "#{board_arr[4]}" + " | " + "#{board_arr[5]}"
    puts "------------"
    puts "#{board_arr[6]}" + " | " + "#{board_arr[7]}" + " | " + "#{board_arr[8]}"
    puts ""
  end
    
end

class Game
  attr_reader :player1, :player2, :board
  
  def initialize(player1, player2, board)
    @player1, @player2 = player1, player2
    @board = board
  end
    
  def play
    current_player = player1
    board.display
    until @board.won?      
      current_mark = (current_player == player1 ? :X : :O)
      board.place_mark(current_player.move(board), current_mark)
      board.display
      current_player = (current_player == player1 ? player2 : player1)
    end
    
    puts "The game is over."
    
    board.winner(current_mark)
    
  end
end

class HumanPlayer
  
  def initialize
  end 
  
  def move(board)
    puts "Enter your board choice 1-9"
    human_move = gets.chomp.to_i-1 #Returns the INDEX choice of user
    if !(board.empty?(human_move))
      until board.empty?(human_move)
        puts "Invaild choice. Try again"
        human_move = gets.chomp.to_i-1
      end
    end
    human_move
  end
  
end

class ComputerPlayer
  
  def initialize
  end
  
  def winning_move_available?(board)
  end
  
  def move(board)
    puts "Enter your board choice 1-9"
    unless winning_move_available?(board)
      computer_move = rand(1..9) - 1
      if board.empty?(computer_move)
        return computer_move
      end
      computer_move = (rand(1..9) - 1) until board.empty?(computer_move)
      return computer_move 
    end
    
  end
  
end

player1 = HumanPlayer.new
player2 = ComputerPlayer.new
board1 = Board.new
game1 = Game.new(player1, player2, board1)
game1.play
