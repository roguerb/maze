require_relative 'point'

class Maze
  attr_accessor :maze

  def initialize(maze_string)
    @maze = parse_maze(maze_string)
    @marker = Marker.new(start_point)
  end

  def find(x, y)
    @maze.select { |v| v.x == x && v.y == y }.first
  end

  def start_point
    @maze.select { |v| v.tile == "A" }.first
  end

  def end_point
    @maze.select { |v| v.tile == "B" }.first
  end

private
  def parse_maze(maze)
    x = 0
    y = 0
    result = []

    maze.each_char do |char|
      if char == "\n"
        y += 1
        x = 0
      else
       result << Point.new(char, x, y)
       x += 1
      end
    end
    result
  end
end
