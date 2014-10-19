class Code
  attr_accessor :current_code
  
  def initialize
    @current_code = []
  end

  def self.random
    random_code_obj = Code.new
    colors = ["R","G","B","Y","O","P"]
    4.times do 
      random_code_obj.current_code << colors[rand(0..5)]
    end
    random_code_obj
  end
  
  def self.parse(input)
    user_code_obj = Code.new
    user_code_obj.current_code = input.split("")
    user_code_obj    
  end
  
  def win?(other_code)
    current_code == other_code.current_code
  end
  
  def tot_matches(other_code)
    exact_matches = exact_matches(other_code)
    near_matches = (near_matches(other_code)-exact_matches)
    "Exact matches: #{exact_matches}, Near Matches: #{near_matches}"
  end
  
  def exact_matches(other_code)
    num_exact_matches = 0  
    current_code.each_with_index do |current_color, index|
      num_exact_matches += 1 if current_color == other_code.current_code[index]
    end
    num_exact_matches
  end
  
  def near_matches(other_code)
    num_near_matches = 0
    code_copy = current_code.dup
    (0..3).each do |index|
      if code_copy.include?(other_code.current_code[index])
        num_near_matches += 1
        code_copy.delete_at(code_copy.index(other_code.current_code[index]))
      end
      
    end
    num_near_matches
  end
  
end

class Game
  attr_reader :num_turns, :human_code
  attr_accessor :secret_code

  def initialize
    @num_turns = 0
    @human_code = Code.new
    @secret_code = Code.random
  end
  
  def make_guess
    puts "What is your guess using the first letter of each color (eg RRRR)"
    user_guess = gets.chomp.upcase
    human_code = Code.parse(user_guess) 
    p secret_code.tot_matches(human_code)
    human_code
  end
  
  def play
    turn = 0
#    p "#{secret_code.current_code}" #Test for win scenario
    until secret_code.win?(human_code) || turn >= 10
      turn += 1
      puts "You're on turn: #{turn}"
      @human_code = make_guess
    end
    
    if secret_code.win?(human_code)
      puts "You win! You're mother would be proud!"
      return nil
    end
    puts "You lost! the secret code was #{secret_code.current_code}"
  end
end

first_game = Game.new
first_game.play
#secret_code = Code.new 
#p secret_code.random

#user_code = Code.new

#p secret_code.tot_matches(user_code)
