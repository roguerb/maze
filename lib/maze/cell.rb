class Cell
  attr_reader :x, :y

  def initialize(cell_type, x, y, maze)
    @type = cell_type
    @x = x
    @y = y
    @maze = maze
  end

  def position
    [@x, @y]
  end

  def neighbors(&block)
    [[@x - 1, @y], [@x + 1, @y], [@x, @y - 1], [@x, @y + 1]].collect { |pos| @maze.cell_at(*pos) }.compact.each(&block)
  end

  def traversable_neighbors(&block)
    neighbors.select(&:traversable?).each(&block)
  end

  def traversable?
    !wall?
  end

  def wall?
    @type == "#"
  end

  def hall?
    @type == " "
  end

  def start?
    @type == "A"
  end

  def end?
    @type == "B"
  end

  def to_s
    @type
  end
end
