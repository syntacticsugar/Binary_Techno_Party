require 'pry'
=begin

a1,a2,a3,
b1,b2,b3
c1,c2,c3

vertical_wins
vertical_wins = [[ "a1", "b1", "c1"]
                ,[ "a2", "b2", "c2"]
                ,[ "a3", "b3", "c3"]]

horizontal_wins = [['a1,' 'a2', 'a3']
                  ,['b1', 'b2', 'b3']
                  ,['c1', 'c2', 'c3']

v = []
1.upto(3).to_a.each do |column|
  ('a'..'c').each do |row|
    v.push([row,column.to_s].join(""))
  end
end
=end

class Board
  def initialize(grid_size=3)
    @size = grid_size
    @alphabet = ('a'..'z').to_a

    @rows = ('a'..@alphabet[@size-1]).to_a
    @columns = (1..@size).to_a.map(&:to_s)

    cells = []
    @columns.each do |column|
      @rows.each do |row|
        cells.push([column.to_s,row].join(""))
      end
    end
    #cells.each_slice(@size).to_a
    faux_hash = cells.map { |cell| [cell, nil] }
    @board = Hash[faux_hash]
    #binding.pry
  end

  def print_board
    puts "#{@board}"
  end

  def position_free? position
    #!@board[position].nil?
    @board[position].nil? #no bang
  end

  def move! (player, position)
    # this is a method that takes in a player, position,
    # and stuffs the player into the position on our board
    # and returns

    if position_free? position
      @board[position] = player # do I need to do player.to_s ?
      #"#{player} moved to #{position}"
      position
    else
      #raise "That space is already occupied, choose another"
      nil #why am i returning nil, though?
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
  #def horizontal_wins
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

  example_hashhh=
  { "a1"=>'x', "b1"=>nil,   "1c"=>nil,
    "a2"=>nil, "b2"=>'x',   "2c"=>nil,
    "a3"=>'y', "b3"=>nil,   "3c"=>'x'   }

  def d_winner? player # player is a string, like 'x'
    d_wins.each do |winning_set| # ex. winning_set = ["a1", "b2", "c3"]

      occupants = winning_set.map { |position| @board[position] }
      # 'occupants' should give me an ARRAY of occupants, I need to check
      # if the occupants match up with the 'player' in question
      # ex: occupants = ['x','x','x']
      matches = occupants.map { |x| x.equal? player }
      if matches.all?
        return true
      end
    end
    false # (no winning set found)
  end

  def alt_d_winner? player
    d_wins.map { |winning_set|
      #occupants = winning_set.map { |position| @board[positions] }
      #occupants.map { |x| x.equal? player }.all?
      winning_set.map { |p| @board[p].equal? player }.all?
    }.any?
  end

  def winner? player
    # returns a bool
    #(h_winner? player) or (v_winner? player) or (d_winner? player)
    winning_sets = h_wins + v_wins + d_wins
    #winning_sets = [h_wins, v_wins, d_wins].flatten
    winning_sets.map { |winning_set|
      winning_set.map { |p| @board[p].equal? player }.all?
    }.any?
  end
end

b = Board.new
p b.v_wins
p b.print_board

=begin
TODO:
refactor the (repeated) ideas in d_winner? alt_d_winner? and winner?
produce a single consolidated/canonical version of the code
=end
