require_relative "spec_helper"
require "maze"

describe Maze do
  MAZE = <<-END_OF_MAZE
#####
#A B#
#####
  END_OF_MAZE
  context "Simple maze" do
    let(:maze) { Maze.new(MAZE) }

    it "has walls" do
      expect(maze.cell_at(0, 0)).to be_wall
    end

    it "has halls" do
      expect(maze.cell_at(2, 1)).to be_hall
    end

    it "has a start point" do
      expect(maze.cell_at(1, 1)).to be_start
    end

    it "has an end point" do
      expect(maze.cell_at(3, 1)).to be_end
    end

    it "knows its starting cell" do
      expect(maze.starting_cell.position).to eq([1, 1])
    end

    it "returns nil for off-grid cell indices" do
      expect(maze.cell_at(-1, -1)).to be_nil
      expect(maze.cell_at(2, 3)).to be_nil
      expect(maze.cell_at(5, 1)).to be_nil
    end

    it "can recreate its string representation" do
      expect(maze.to_s).to eq(MAZE)
    end
  end

  context "Solvable maze" do
    before(:each) do
      @solver = double("Solver")
      @maze = Maze.new("", @solver)
      @solution = double("Path", :complete? => true, :steps => 42).as_null_object
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

    it "draws the solution" do
      expect(@solution).to receive(:draw)
      @maze.solution
    end
  end

  context "Unsolvable maze" do
    before(:each) do
      @solver = double("Solver")
      @maze = Maze.new("", @solver)
      @solution = double("Path", :complete? => false, :steps => 0)
      expect(@solver).to receive(:solve).once.with(@maze) { @solution }
    end

    it "tries to solve the maze" do
      expect(@maze).not_to be_solvable
    end

    it "has zero steps in its solution" do
      expect(@maze.steps).to eq(0)
    end

    it "doesn't draw the solution" do
      expect(@solution).not_to receive(:draw)
      @maze.solution
    end
  end
end
