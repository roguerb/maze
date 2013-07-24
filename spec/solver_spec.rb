require_relative "spec_helper"

describe Solver do
  let(:solver) { Solver.new }
  it "can't solve a degenerate maze" do
    maze = Maze.new(<<-MAZE)
#####
#A#B#
#####
    MAZE
    expect(solver.solve(maze)).not_to be_complete
  end

  it "solves a simple one-step maze" do
    maze = Maze.new(<<-MAZE)
####
#AB#
####
    MAZE
    expect(solver.solve(maze).positions).to eq([[1, 1], [2, 1]])
  end

  it "solves a simple multi-step maze" do
    maze = Maze.new(<<-MAZE)
#####
#A B#
#####
    MAZE
    expect(solver.solve(maze).positions).to eq([[1, 1], [2, 1], [3, 1]])
  end

  it "finds the shortest path" do
    maze = Maze.new(<<_MAZE)
######
#    #
# ## #
# AB #
######
_MAZE
    expect(solver.solve(maze).positions).to eq([[2, 3], [3, 3]])
  end
end
