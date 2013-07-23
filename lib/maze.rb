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

  def starting_cell
    @rows.each_with_index do |row, y|
      x = row.index("A")
      return [x, y] if x
    end
    nil
  end

  def neighbors_of(x, y, &block)
    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each(&block)
  end

  def cell_at(x, y)
    return nil unless (0...@rows.size).include?(y)
    row = @rows[y]
    return nil unless (0...row.size).include?(x)
    row[x]
  end

  private

  def parse(maze_string)
    @rows = maze_string.lines.map(&:chomp).to_a
  end

  def solution
    @solution ||= solve
  end

  def solve
    @solver.solve(self)
  end
end
