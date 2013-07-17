class Tile
  attr_accessor :type, :x, :y

  def initialize(type, x, y)
    @type, @x, @y = type, x, y
  end

  def wall?
    type == :wall
  end

  def start?
    type == :start
  end

  def end?
    type == :end
  end
end
