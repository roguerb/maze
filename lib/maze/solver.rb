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

      path.successors.each do |new_path|
        enqueue(new_path)
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
