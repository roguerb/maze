class Marker
  attr_accessor :x, :y
  attr_reader :maze

  def initialize(point, maze)
    @x = point.x
    @y = point.y
    @maze = maze
  end

  def available_moves
    [north, east, south, west].map do |direction|
      if available_move?(direction)
        direction.tile # HACK: using tile to store the direction sym
      end
    end.compact
  end

  def available_move?(direction)
    maze.find(direction.x, direction.y).tile != Maze.wall
  end

  def north
    Point.new(Direction.north, x, y - 1)
  end

  def south
    Point.new(Direction.south, x, y + 1)
  end

  def east
    Point.new(Direction.east, x + 1, y)
  end

  def west
    Point.new(Direction.west, x - 1, y)
  end
end
