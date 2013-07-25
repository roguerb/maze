require_relative "maze/solver"
require_relative "maze/path"
require_relative "maze/cell"

class Maze
  def initialize(maze_string, solver = Solver.new)
    @solver = solver
    @cells = []
    parse(maze_string)
  end

  def solvable?
    solution.complete?
  end

  def steps
    solution.steps
  end

  def solution
    @solution ||= solve
  end

  def starting_cell
    @cells.detect(&:start?)
  end

  def cell_at(x, y)
    @cells.detect { |cell| cell.position == [x, y] }
  end

  def to_s
    result = ""
    @cells.each_cons(2) do |first, second|
      result << first.to_s
      result << "\n" unless first.y == second.y
    end
    result << @cells.last.to_s << "\n"
    result
  end

  private

  def parse(maze_string)
    maze_string.lines.each_with_index do |line, y|
      line.chomp.each_char.each_with_index do |char, x|
        @cells << Cell.new(char, x, y, self)
      end
    end
  end

  def solve
    @solver.solve(self)
  end
end
