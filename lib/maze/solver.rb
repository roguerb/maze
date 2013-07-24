require_relative "path"

class Solver
  def initialize
    @paths = []
  end

  def solve(maze)
    enqueue(Path.new(maze.starting_cell))

    while !done? do
      path = next_path
      return path if path.complete?

      path.current_cell.traversable_neighbors.each do |neighbor|
        enqueue(path.with(neighbor)) unless path.include?(neighbor)
      end
    end
    Path.new
  end

  private
  def done?
    @paths.empty?
  end

  def enqueue(path)
    @paths << path
  end

  def next_path
    @paths.shift
  end
end
