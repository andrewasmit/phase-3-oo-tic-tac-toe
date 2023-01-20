require 'pry'

class TicTacToe
    attr_accessor :board, :turn_count
    
    def initialize
        @board= [' ',' ',' ',' ',' ',' ',' ',' ',' ']
        @turn_count=0
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        line1 = " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        line2 = " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        line3 = " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        row = "-----------"
        puts line1 + row + line2 + row + line3
    end

    def input_to_index num
        num = num.to_i
        num -1
    end

    def move(idx, token ='X')
        if @turn_count % 2 == 0
            @board[idx] = token
            @turn_count+=1
        else
            @board[idx] = "O"
            @turn_count+=1
        end
    end

    def position_taken? idx
        @board[idx] == ' ' ? false : true
    end

    def valid_move? position
        if position <9 && position >=0
            !position_taken?(position)
        else 
            false
        end
    end

    def turn_count
        arr = @board.filter do |e|
            e != " "
        end
        arr.length
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn 
        turn = current_player
        move = gets.chomp 
        idx = input_to_index(move)
        if valid_move?(idx)
            move(idx, turn)
            display_board()
        else
            turn()
        end
    end

    def won?
        x_arr=[]
        o_arr=[]
        @board.map.with_index { |e, i| x_arr << i if e == 'X' }
        @board.map.with_index { |e, i| x_arr << i if e == 'O' }
        if check_for_win(x_arr) == nil then
            check_for_win(y_arr)
        else 
            check_for_win(x_arr)
        end
    end

    def check_for_win arr
        progress_arr = WIN_COMBINATIONS.map do |win_arr|
            (win_arr - arr).empty?
        end 
        windex = progress_arr.find_index(true)
        if windex == nil
            false
        else
            WIN_COMBINATIONS[windex]
        end
    end


    def full?
        arr = @board.filter do |e|
            e == " "
        end
        arr.length == 0 ? true : false
    end


# End of Class Declaration
end