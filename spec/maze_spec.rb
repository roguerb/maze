require_relative "spec_helper"
require "maze"

describe Maze do
  MAZE = <<-END_OF_MAZE
#####
#A B#
#####
  END_OF_MAZE

  let(:maze) { Maze.new(MAZE) }

  it "has walls" do
    expect(maze.at(0, 0)).to eq("#")
  end

  it "has halls" do
    expect(maze.at(2, 1)).to eq(" ")
  end

  it "has a start point" do
    expect(maze.at(1, 1)).to eq("A")
  end

  it "has an end point" do
    expect(maze.at(3, 1)).to eq("B")
  end

  it "returns nil for off-grid cell indices" do
    expect(maze.at(-1, -1)).to be_nil
    expect(maze.at(2, 3)).to be_nil
    expect(maze.at(5, 1)).to be_nil
  end
end
