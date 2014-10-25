class Game
  def initialize(guessing_player,checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end
  
  def play
    @secret_word_length = @checking_player.pick_secret_word
    won = false
    5.times do 
      encoded_word = @checking_player.handle_guess_response
      @guessing_player.receive_secret_length(encoded_word)
      current_guess = @guessing_player.guess
      @checking_player.check_guess(current_guess)
      p @checking_player.handle_guess_response
      won = !(@checking_player.encoded_word.include?("_"))
      break if won
    end
    won ? (puts "You win, Congrats!") : (puts "You lose.")
  end
end

class Human
  attr_accessor :encoded_word
  
  def pick_secret_word
    puts "Think of a word and remember it and enter its length"
    secret_word_length = gets.chomp.to_i
    @encoded_word = []
    secret_word_length.times do 
      @encoded_word << "_"
    end
    @encoded_word = @encoded_word.join
    secret_word_length
  end
  
  def receive_secret_length(secret_word_length)
    secret_word_length
  end
  
  def guess
    puts "What is your guess?"
    @guess = gets.chomp
    @guess
  end
  
  def check_guess(guess)
    puts "input updated encoded word"
    @encoded_word = gets.chomp
  end
  
  def handle_guess_response
    @encoded_word
  end
  
end

class Computer
  attr_accessor :encoded_word
  
  def initialize
    @dictionary = File.readlines("dictionary.txt")
    # p @dictionary
    @num_guess = 0
  end
  
  def pick_secret_word
    @secret_word = @dictionary.sample.chomp
    #p @secret_word
    @encoded_word = []
    @secret_word.length.times do 
      @encoded_word << "_"
    end
    @secret_word
  end
  
  def receive_secret_length(encoded_word)
    @encoded_word = encoded_word
    @secret_word_length = encoded_word.length
  end
  
  def guess
    @num_guess += 1
    letter_frequency = {}
    
    possible_words = @dictionary.select do |word| 
      word.strip.length == @secret_word_length
    end
    
    possible_words.each do |word|
      word.strip.split("").each do |letter|
        if letter_frequency.include?(letter)
          letter_frequency[letter] += 1
        else
          letter_frequency[letter] = 1
        end
      end
    end
    
    #p "letter frequency is: #{letter_frequency}"
    sorted_frequent_letters = letter_frequency.keys.sort_by { |key| letter_frequency[key] }
    @guess = sorted_frequent_letters[(0-@num_guess)]
    puts "Computer's guess is: #{@guess}"
    @guess
  end
  
  def check_guess(guess)
    @secret_word.split("").each_with_index do |char, index|
      if char == guess
        self.encoded_word[index] = char
      end
    end
  end
  
  def handle_guess_response
    p @encoded_word.join
  end
end

h = Human.new
c = Computer.new
g = Game.new(h,c)
g.play