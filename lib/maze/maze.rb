require_relative "solver"
require_relative "path"
require_relative "cell"

class Maze
  def initialize(maze_string, solver = Solver.new)
    @solver = solver
    @rows = []
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
    @rows.each { |row| row.each { |cell| return cell if cell.start? } }
  end

  def cell_at(x, y)
    cell_in_row(row_at(y), x)
  end

  def to_s
    @rows.collect { |row| row.collect(&:to_s).join << "\n" }.join
  end

  private

  def parse(maze_string)
    @rows = maze_string.lines.each_with_index.collect { |line, y|
      line.chomp.chars.each_with_index.collect { |char, x|
        Cell.new(char, x, y, self)
      }
    }
  end

  def solve
    solution = @solver.solve(self)
    solution.draw if solution.complete?
    solution
  end

  def row_at(index)
    return nil unless (0...@rows.size).include?(index)
    @rows[index]
  end

  def cell_in_row(row, index)
    return nil unless row && (0...row.size).include?(index)
    row[index]
  end
end
