require_relative "spec_helper"

describe Solver do
  let(:solver) { Solver.new }
  it "can't solve a degenerate maze" do
    maze = Maze.new(<<-MAZE)
#####
#A#B#
#####
    MAZE
    expect(solver.solve(maze)).to be_empty
  end

  it "solves a simple maze" do
    maze = Maze.new(<<-MAZE)
####
#AB#
####
    MAZE
    expect(solver.solve(maze)).to eq([[1, 1], [2, 1]])
  end
end
