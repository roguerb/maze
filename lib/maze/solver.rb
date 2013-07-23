class Solver
  def solve(maze)
    start_x, start_y = *maze.starting_cell
    finish = maze.neighbors_of(start_x, start_y).detect { |x, y| maze.cell_at(x, y) == "B" }
    finish ? [[start_x, start_y], finish] : []
  end
end
