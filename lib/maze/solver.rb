require_relative "path"

class Solver
  def solve(maze)
    paths = [Path.new(maze.starting_cell)]
    while !paths.empty? do
      path = paths.shift
      return path if path.complete?
      path.current_cell.traversable_neighbors.each do |neighbor|
        paths << path.with(neighbor) unless path.include?(neighbor)
      end
    end
    Path.new
  end
end
