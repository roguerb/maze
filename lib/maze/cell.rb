class Cell
  WALL = "#"
  HALL = " "
  START = "A"
  FINISH = "B"
  NORTH = "^"
  SOUTH = "v"
  EAST = ">"
  WEST = "<"

  attr_reader :type, :x, :y

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
    [NORTH, SOUTH, EAST, WEST].include?(@type)
  end

  def visit(cell)
    raise "Cannot visit a wall" if wall?
    return unless hall?

    @type = case cell
              when north_neighbor
                NORTH
              when south_neighbor
                SOUTH
              when east_neighbor
                EAST
              when west_neighbor
                WEST
              else
                raise "Can't visit a cell that isn't a neighbor"
            end
  end

  def to_s
    @type
  end

  private

  def all_neighbors
    [west_neighbor, east_neighbor, north_neighbor, south_neighbor]
  end

  def north_neighbor
    @maze.cell_at(@x, @y - 1)
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
