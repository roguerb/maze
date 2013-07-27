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

  context "When solving" do
    ANY_MAZE = ""

    let(:solver) { double("Solver") }
    let(:maze) { Maze.new(ANY_MAZE, solver) }
    let(:solution) { Path.new }

    it "delegates solving to its solver" do
      expect(solver).to receive(:solve).with(maze) { solution }
      expect(maze.solution).to be(solution)
    end

    it "knows how many steps are in the solution" do
      expect(solver).to receive(:solve).with(maze) { solution }
      allow(solution).to receive(:steps) { 42 }
      expect(maze.steps).to eq(42)
    end

    it "only solves the maze once" do
      expect(solver).to receive(:solve).once.with(maze) { solution }
      maze.solution
      maze.solvable?
      maze.steps
    end

    context "a solvable maze" do
      let(:good_solution) { double("Path", :complete? => true).as_null_object }

      before(:each) do
        expect(solver).to receive(:solve).with(maze) { good_solution }
      end

      it "is solvable" do
        expect(maze).to be_solvable
      end

      it "draws the solution" do
        expect(good_solution).to receive(:draw)
        maze.solution
      end
    end

    context "an unsolvable maze" do
      let(:no_solution) { double("Path", :complete? => false) }
      before(:each) do
        expect(solver).to receive(:solve).with(maze) { no_solution }
      end

      it "is not solvable" do
        expect(maze).not_to be_solvable
      end

      it "doesn't draw the solution" do
        expect(no_solution).not_to receive(:draw)
        maze.solution
      end
    end
  end
end
