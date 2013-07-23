class Solver
  def solve(maze)
    paths = [[maze.starting_cell]]
    while !paths.empty? do
      path = paths.shift
      cell = path.last
      return path if cell.end?
      cell.traversable_neighbors.each do |neighbor|
        paths << path + [neighbor] unless path.include?(neighbor)
      end
    end
    []
  end
end
