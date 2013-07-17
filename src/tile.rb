class Tile
  attr_accessor :type, :x, :y

  def initialize(type, x, y)
    @type, @x, @y = type, x, y
  end
end
