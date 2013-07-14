require_relative 'tile'
require_relative 'marker'

class Maze
  attr_accessor :tiles, :start_point

  def initialize(maze_string)
    @tiles = parse_maze(maze_string)
    @marker = Marker.new(start_point)
  end

  def find(x, y)
    @tiles.select { |v| v.x == x && v.y == y }.first
  end

  def start_point
    @tiles.select { |v| v.type == :start }.first
  end

  def end_point
    @tiles.select { |v| v.type == :end }.first
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
    case char
    when '#'
      :wall
    when ' '
      :floor
    when 'A'
      :start
    when 'B'
      :end
    end
  end
end
