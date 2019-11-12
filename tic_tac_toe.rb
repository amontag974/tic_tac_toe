class Player
    attr_accessor :name, :char, :winner

    def initialize(name,char)
        @name = name
        @char = char
        @winner = false
    end

    def announce_turn
        puts "#{self.name}, it's your turn. Please choose a number."
    end

end

class Board
    attr_reader :positions, :positions, :positions

    @@turn = 1

    def initialize
        @positions = create_row
    end

    def create_row
        row = Array.new
        9.times { row << " "}
        row
    end

    def play_turn(player)
        player.announce_turn
        player_selection(player)
        self.display_board
    end

    def player_selection(player)
        selection = gets.chomp.to_i
        while !(0..8).include?(selection) || check_for_filled_square(selection)
            puts "Please enter a number for an unfilled square: "
            selection = gets.chomp.to_i
        end
        self.fill_in_square(selection,player.char)
    end

    def display_instructions
        puts "Please choose the number that corresponds with the square you would like to select: "
        puts " "
        puts " 0 | 1 | 2 "
        puts "-----------"
        puts " 3 | 4 | 5 "
        puts "-----------"
        puts " 6 | 7 | 8 "
        puts " "
    end

    def check_for_filled_square(selection)
        true if @positions[selection] != " "
    end

    def fill_in_square(selection,char)
        case selection
        when 0
            @positions[0] = char
        when 1
            @positions[1] = char
        when 2
            @positions[2] = char
        when 3
            @positions[3] = char
        when 4
            @positions[4] = char
        when 5
            @positions[5] = char
        when 6
            @positions[6] = char
        when 7
            @positions[7] = char
        when 8
            @positions[8] = char
        end
    end

    def display_board
        puts " "
        puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
        puts "-----------"
        puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
        puts "-----------"
        puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
        puts " "
    end 

    def check_for_win
        if @positions[0] == @positions[3] && @positions[0] == @positions[6] && @positions[0] != " "
            true
        elsif @positions[1] == @positions[4] && @positions[1] == @positions[7] && @positions[1] != " "
            true 
        elsif @positions[2] == @positions[5] && @positions[2] == @positions[8] && @positions[2] != " "
            true  
        elsif @positions[0] == @positions[1] && @positions[0] == @positions[2] && @positions[0] != " "
            true  
        elsif @positions[3] == @positions[4] && @positions[3] == @positions[5] && @positions[3] != " "
            true  
        elsif @positions[6] == @positions[7] && @positions[6] == @positions[8] && @positions[6] != " "
            true 
        elsif @positions[0] == @positions[4] && @positions[4] == @positions[8] && @positions[0] != " "
            true 
        elsif @positions[2] == @positions[4] && @positions[4] == @positions[6] && @positions[2] != " "
            true
        end        
    end

    def determine_winner(player1,player2)
        if @@turn % 2 == 0
            puts "#{player1.name} wins!"
        else
            puts "#{player2.name} wins!"
        end
    end

    def determine_player_turn(player1,player2)
        if @@turn % 2 != 0
            self.play_turn(player1)
        else
            self.play_turn(player2)
        end
        @@turn +=1
    end

    def play_game(player1,player2)
        while @@turn < 6
            self.determine_player_turn(player1,player2)
        end
        while @@turn < 10
            if self.check_for_win
                self.determine_winner(player1, player2)
                break
            else
                self.determine_player_turn(player1,player2)
            end
        end
        puts "The game is over. It's a tie!" if @@turn == 10
    end
end

puts "Player 1 - Please enter your name: "
name1 = gets.chomp
player1 = Player.new(name1, "X")
puts "Player 2 - Please enter your name: "
name2 = gets.chomp
player2 = Player.new(name2,"O")
gameboard = Board.new
gameboard.display_instructions
gameboard.play_game(player1,player2)

