require_relative "maze/solver"
require_relative "maze/path"
require_relative "maze/cell"

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
    @rows.each do |row|
      row.each do |cell|
        return cell if cell.start?
      end
    end
  end

  def cell_at(x, y)
    return nil unless (0...@rows.size).include?(y)
    row = @rows[y]
    return nil unless (0...row.size).include?(x)
    row[x]
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
end
