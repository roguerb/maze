class Solver
  def solve(maze)
    start_x, start_y = *maze.starting_cell
    solve_from(maze, start_x, start_y)
  end

  def solve_from(maze, x, y, path = [])
    return [] if path.include?([x, y])

    current_cell = maze.cell_at(x, y)
    return [] if current_cell == "#"

    next_path = path + [[x, y]]
    return next_path if current_cell == "B"

    maze.neighbors_of(x, y).map { |next_x, next_y| solve_from(maze, next_x, next_y, next_path) }.detect(-> { [] }) { |solution| not solution.empty? }
  end
end
