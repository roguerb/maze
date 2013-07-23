class Solver
  def solve(maze)
    paths = [[maze.starting_cell]]
    while !paths.empty? do
      path = paths.shift
      cell = path.last
      return path if cell.end?
      maze.neighbors_of(cell).each do |neighbor|
        paths << path + [neighbor] unless path.include?(neighbor) || !neighbor.traversable?
      end
    end
    []
  end
end
