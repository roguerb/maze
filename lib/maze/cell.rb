class Cell
  WALL = "#"
  HALL = " "
  START = "A"
  FINISH = "B"
  VISITED = "."

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
    all_neighbors.compact.each(&block)
  end

  def traversable_neighbors(&block)
    neighbors.select(&:traversable?).each(&block)
  end

  def traversable?
    !wall?
  end

  def wall?
    @type == WALL
  end

  def hall?
    @type == HALL || visited?
  end

  def start?
    @type == START
  end

  def end?
    @type == FINISH
  end

  def visited?
    @type == VISITED
  end

  def visit
    raise "Cannot visit a wall" if wall?

    @type = VISITED if hall?
  end

  def to_s
    @type
  end

  private

  def all_neighbors
    [west_neighbor, east_neighbor, north_neighbor, south_neighbor]
  end

  def north_neighbor
    @maze.cell_at(@x, @y -1)
  end

  def south_neighbor
    @maze.cell_at(@x, @y + 1)
  end

  def west_neighbor
    @maze.cell_at(@x - 1, @y)
  end

  def east_neighbor
    @maze.cell_at(@x + 1, @y)
  end
end
