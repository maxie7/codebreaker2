module Codebreaker
  class Game
    attr_reader :move_number, :secret_code, :hints
    N_HINT  = 1
    N_MOVES = 12

    def initialize
      @secret_code = ""
      @hints = N_HINT
      @move_number = N_MOVES
    end

    def start
      @secret_code = generate_secret_code
    end

    def victory
      puts "Congratulations!!! YOU WIN!"
    end

    def game_over
      puts "GAME OVER! You make me lough! The secret code is #{@secret_code}"
    end

    def guess_check(player_input)
      input_not_eq = ""
      code_not_eq  = ""
      result       = ""

      return "number failed" unless player_input.match(/^[1-6]{4}/)
      return "the number must have 4 digits" if player_input.size != 4

      4.times do |x|
        if player_input[x] == @secret_code[x]
          result << "+"
        else
          code_not_eq << @secret_code[x]
          input_not_eq << player_input[x]
        end
      end

      input_not_eq.each_char do |x|
        if code_not_eq.include? x
          result << "-"
          code_not_eq.slice!(x)
          input_not_eq.slice!(x)
        end
      end

      @move_number -= 1
      return "Game over" if @move_number == 0
      return "You win" if result == "++++"
      result
    end

    def moves
      N_MOVES - @move_number
    end

    def hint
      return "You have used the hint already" if @hints == 0
      @hints -= 1
      x = rand(4)
      "One of the numbers in the secret code is #{@secret_code[x]}"
    end

    def generate_secret_code
      (1..4).map{rand(1..6)}.join
    end
  end
end
