require_relative 'tile'
require_relative 'marker'

class Maze
  attr_accessor :tiles

  def initialize(maze_string)
    @tiles = parse_maze(maze_string)
    @marker = Marker.new(start_point.x, start_point.y)
  end

  TILE_TYPES = {
    '#' => :wall,
    ' ' => :floor,
    'A' => :start,
    'B' => :end
  }

  def tile_type_at(x, y)
    @tiles.detect { |v| v.x == x && v.y == y }.type
  end

  def tile_at(x, y)
    @tiles.detect { |v| v.x == x && v.y == y }
  end

  def start_point
    @tiles.detect(&:start?)
  end

  def end_point
    @tiles.detect(&:end?)
  end

  def shortest_path?
    shortest_path
  end

  def shortest_path
    paths = [[start_point]]
    while !paths.empty? do
      current_path = paths.shift
      current_cell = current_path.last
      return current_path if current_cell.end?
      valid_neighbors =
        neighbors_of(current_cell).reject(&:wall?).reject do |neighbor|
          current_path.include?(neighbor)
        end
      valid_neighbors.each do |neighbor|
        paths << current_path + [neighbor]
      end
    end
    false
  end

  def neighbors_of(tile)
    [
      tile_at(tile.x - 1, tile.y),
      tile_at(tile.x + 1, tile.y),
      tile_at(tile.x, tile.y - 1),
      tile_at(tile.x, tile.y + 1)
    ].compact
  end

  private

  def parse_maze(maze)
    x, y = 0, 0
    result = []

    maze.each_char do |char|
      if char == "\n"
        y += 1
        x = 0
      else
       type = tile_type(char)
       result << Tile.new(type, x, y)
       x += 1
      end
    end
    result
  end

  def tile_type(char)
    TILE_TYPES[char]
  end
end
