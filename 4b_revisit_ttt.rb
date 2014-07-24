require 'pry'
=begin
    1___2___3
a|  a1, a2, a3   rowz
b|  b1, b2, b3
c|  c1, c2, c3


vertical_wins = [[ 'a1', 'b1', 'c1'],
                 [ 'a2', 'b2', 'c2'],
                 [ 'a3', 'b3', 'c3']]

horizontal_wins = [[ 'a1', 'a2', 'a3'],
                   [ 'b1', 'b2', 'b3'],
                   [ 'c1', 'c2', 'c3']]

=end

v_wins = []
1.upto(3).each do |column|
  ('a'..'c').each do |row|
    v_wins.push([row+column.to_s].join(''))
  end
end
v_wins.each_slice(3).to_a

h_wins = []
('a'..'c').each do |row|
  1.upto(3).each do |column|
    h_wins.push([row+column.to_s].join(''))
  end
end
h_wins.each_slice(3).to_a

class Board
  attr_accessor :board
  def initialize(grid_size=3)
    @size = grid_size
    #@rows, @columns = @size, @size
    # side note, the above line returns 
    # the arrray [@size,@size].  
    # FUCKEN WEIRRRRRD...
    @alphabet = ('a'..'z').to_a
    @rows = @alphabet[0..(@size-1)]
    @columns = (1..@size).to_a.map(&:to_s)
    p cells = []
    @columns.each do |column|
      @rows.each do |row|
        cells.push(row + column.to_s)
      end
    end
    #cells.each_slice(@size).to_a
    faux_hash = cells.map { |cell| [cell, nil] }
    @board = Hash[faux_hash]
  end

  def position_free? position
    @board[position].nil?
  end

  def move! (player, position)
    if position_free? position
      @board[position] = player #to_s later
      position
    else
      raise 'Space not available, choose another'
      nil
    end
  end

  # return an array of vertical wins
  def v_wins
    v = []
    @columns.each do |column|
      @rows.each do |row|
        v.push([row,column].join(""))
      end
    end
    v.each_slice(@size).to_a # Array.sort! later
  end

  # return an array of horizontal wins
  def h_wins
    h = []
    @rows.each do |row|
      @columns.each do |column|
        h.push([row, column].join(''))
      end
    end
    h.each_slice(@size).to_a
  end

  #def diagonal_wins
  def d_wins
    diag1, diag2 = [], []
    0.upto(@size-1).each do |i| # |i| for index
      diag1.push(@rows[i] + @columns[i])
      diag2.push( @rows[@size-1-i] + @columns[i]) # this last bit was tricky
    end
    # [[a1,b2,c3]   =>  a++, 1++
    # ,[a3,b2,c1]]  =>  a++, @size--
    [diag1, diag2]
  end

  # checks if a player has any wins
  def winner? player
    all_wins = v_wins + h_wins + d_wins
    #binding.pry
    all_wins.any? do |cells|
      # ex. cells= ["a2", "b2", "c2"] 
      cells.all? do |position|
        @board[position] == player
      end
    end
  end


end

b = Board.new
#b.v_wins
p b.winner? 'x'
b.move!('x', 'a1') #ruby says NO SPACE before args!
p b.winner? 'x'
b.move!('x', 'a2')
p b.winner? 'x'
b.move!('x', 'a3')
p b.winner? 'x'

# CONTROLLER
class Game
  attr_accessor :choice, :player1, :player2
  def initialize(players=2, grid_size=3)
    @game_state = true
    @player1 = 'Player (X)'
    @player2 = 'Player (Y)'

    @b = Board.new

    puts "Welcome to this two-player game of Tic Tac Toe.  How many rows/columns would you guys like?  Well actually, your opinion doesn't matter.  The default grid size for now is 3 by 3. \n
    Player 1 is 'X'. (uppercase or lowercase)
    Player 2 is 'Y'. (uppercase or lowercase)\n\n
    Hit 'enter' to continue."
    gets #waits for user to hit 'enter'


    begin_game
  end

  def begin_game
    until @b.winner(@player1) or @b.winner(@player2)
      puts "Okay, so here's how the board looks so far:\n
      #{@b.board[0]}\n
      #{@b.board[1]}\n
      #{@b.board[2]}\n
      \n"
      '#{player1}, which cell do you choose?'
      @choice = gets.chomp.to_s.downcase

      @b.move!(@player1, @choice)

      puts "#{@player1} moved to #{@choice}:"
      puts "#{@b.board}\n"

      #@game_state = false
    end
  end
end




