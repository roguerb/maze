require_relative "spec_helper"
require "maze"

describe Maze do
  context "Simple maze" do
    let(:maze) { Maze.new(<<-MAZE)
#####
#A B#
#####
    MAZE
    }

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

  context "Solvable maze" do
    before(:each) do
      @solver = double("Solver")
      @maze = Maze.new("", @solver)
      @solution = (1..42).to_a
      expect(@solver).to receive(:solve).once.with(@maze) { @solution }
    end

    it "solves the maze" do
      expect(@maze).to be_solvable
    end

    it "counts the steps in the solution" do
      expect(@maze.steps).to eq(42)
    end

    it "only solves the maze once" do
      @maze.solvable?
      @maze.steps
    end
  end

  context "Unsolvable maze" do
    before(:each) do
      @solver = double("Solver")
      @maze = Maze.new("", @solver)
      @solution = []
      expect(@solver).to receive(:solve).once.with(@maze) { @solution }
    end

    it "tries to solve the maze" do
      expect(@maze).not_to be_solvable
    end

    it "has zero steps in its solution" do
      expect(@maze.steps).to eq(0)
    end
  end
end
