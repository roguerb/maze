require_relative "spec_helper"
require "maze/cell"

describe Cell do
  let (:maze) { double("Maze") }

  context "Any cell" do
    let (:cell) { Cell.new(" ", 3, 4, maze) }

    it "knows its position" do
      expect(cell.position).to eq([3, 4])
    end

    it "knows its neighbors" do
      neighbors = Array.new(4) { double("Cell") }
      [[2, 4], [4, 4], [3, 3], [3, 5]].each_with_index do |pos, index|
        allow(maze).to receive(:cell_at).with(*pos) { neighbors[index] }
      end

      expect(cell.neighbors.to_a).to eq(neighbors)
    end

    it "doesn't yield off-grid neighbors" do
      neighbor = double("Cell")
      allow(maze).to receive(:cell_at).and_return(nil, nil, neighbor, nil)

      expect(cell.neighbors.to_a).to eq([neighbor])
    end

    it "knows its traversable neighbors" do
      traversable = double("Cell", :traversable? => true)
      non_traversable = double("Cell", :traversable? => false)
      allow(maze).to receive(:cell_at).and_return(non_traversable, nil, traversable, nil)

      expect(cell.traversable_neighbors.to_a).to eq([traversable])
    end

  end

  context "A wall" do
    let (:cell) { Cell.new("#", 1, 2, maze) }

    it "is a wall" do
      expect(cell).to be_wall
    end

    it "is not traversable" do
      expect(cell).not_to be_traversable
    end

    it "cannot be visited" do
      expect { cell.visit }.to raise_error
    end
  end

  context "A hall" do
    let (:cell) { Cell.new(" ", 2, 1, maze) }

    it "is a hall" do
      expect(cell).to be_hall
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    it "can be visited" do
      cell.visit
      expect(cell).to be_visited
    end

    it "is still a hall after visiting" do
      cell.visit
      expect(cell).to be_hall
    end
  end

  context "The start point" do
    let (:cell) { Cell.new("A", 3, 2, maze) }

    it "is the start point" do
      expect(cell).to be_start
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    it "is not affected by visiting" do
      cell.visit
      expect(cell).not_to be_visited
    end
  end

  context "The end point" do
    let (:cell) { Cell.new("B", 3, 4, maze) }

    it "is the end point" do
      expect(cell).to be_end
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    it "is not affected by visiting" do
      cell.visit
      expect(cell).not_to be_visited
    end
  end
end
