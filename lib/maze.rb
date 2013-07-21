require_relative "maze/solver"

class Maze
  def initialize(maze_string, solver = Solver.new)
    @solver = solver
    parse(maze_string)
  end

  def solvable?
    not solution.empty?
  end

  def steps
    solution.length
  end

  def at(x, y)
    return nil unless (0...@cells.size).include?(y)
    row = @cells[y]
    return nil unless (0...row.size).include?(x)
    row[x]
  end

  private

  def parse(maze_string)
    @cells = maze_string.lines.map(&:chomp).to_a
  end

  def solution
    @solution ||= solve
  end

  def solve
    @solver.solve(self)
  end
end
