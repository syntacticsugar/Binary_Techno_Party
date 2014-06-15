require 'pry'
=begin

g =
[[],[],[]   # g[0], g[1], g[2],
,[],[],[]   # g[3], g[4], g[5],
,[],[],[]]  # g[6], g[7], g[8],

a1,a2,a3,
b1,b2,b3
c1,c2,c3

a1,a2,a3,a4
b1,b2,b3,b4
c1,c2,c3,c4
d1,d2,d3,d4


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
  end

  def position_free? position
    !@board[position].nil?
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
      nil
    end
  end

  # return an array of vertical wins
  def v_wins
    v = []
    @columns.each do |column| # WHY MY CODE SO UGLEE?  ARGH
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

  def diagonal_wins
    diag1, diag2 = [], []
    0.upto(@size-1).each do |i| # |i| for index
      diag1.push(@rows[i] + @columns[i])
      diag2.push( @rows[@size-1-i] + @columns[i]) # this last bit was tricky
    end
    # [[a1,b2,c3]   =>  a++, 1++
    # ,[a3,b2,c1]]  =>  a++, @size--
    [diag1, diag2]
  end

  def winner? player
    # returns a bool
    (h_winner? player) or (v_winner? player) or (d_winner? player)
  end
end

b = Board.new
p b.diagonal_wins
