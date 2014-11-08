# method one
Cell = Struct.new(:value, :next)
list = Cell.new('head', nil)

# method two
class Entry
  attr_accessor :next, :data
  def initialize data
    @next = nil
    @data = data
  end
end

class List
  attr_accessor :name
  def initialize
    @head = nil
    @tail = nil
  end

  

=begin
  def cons entry
    if !@head?
      @head = entry
    end
    if !@tail?
      @tail = entry
    end
=end
end

