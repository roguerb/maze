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
    solvable? ? solution.length - 1 : 0
  end

  def starting_cell
    @rows.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        return [x, y] if cell.start?
      end
    end
    nil
  end

  def neighbors_of(x, y, &block)
    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].reject { |each_x, each_y| cell_at(each_x, each_y).nil? }.each(&block)
  end

  def cell_at(x, y)
    return nil unless (0...@rows.size).include?(y)
    row = @rows[y]
    return nil unless (0...row.size).include?(x)
    row[x]
  end

  private

  def parse(maze_string)
    @rows = maze_string.lines.collect { |line| line.chomp.each_char.collect { |cell| Cell.new(cell) } }
  end

  def solution
    @solution ||= solve
  end

  def solve
    @solver.solve(self)
  end
end
