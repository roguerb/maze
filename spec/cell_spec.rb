require_relative "spec_helper"
require "maze/cell"

describe Cell do
  let (:maze) { double("Maze") }
  let (:neighbors) { Array.new(4) { double("Cell") } }

  def new_cell(type)
    Cell.new(type, 3, 4, maze)
  end

  def stub_neighbors
    [[2, 4], [4, 4], [3, 3], [3, 5]].each_with_index do |pos, index|
      allow(maze).to receive(:cell_at).with(*pos) { neighbors[index] }
    end
  end

  context "Any cell" do
    let (:cell) { new_cell(Cell::HALL) }

    it "knows its position" do
      expect(cell.position).to eq([3, 4])
    end

    it "knows its neighbors" do
      stub_neighbors
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
    let (:cell) { new_cell(Cell::WALL) }

    it "is a wall" do
      expect(cell).to be_wall
    end

    it "is not traversable" do
      expect(cell).not_to be_traversable
    end

    it "cannot visit a neighbor" do
      expect { cell.visit(double("Cell")) }.to raise_error
    end
  end

  context "A hall" do
    let (:cell) { new_cell(Cell::HALL) }

    it "is a hall" do
      expect(cell).to be_hall
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    context "with neighbors" do
      before(:each) { stub_neighbors }

      it "can visit a neighbor" do
        cell.visit(neighbors.first)
        expect(cell).to be_visited
      end

      it "is still a hall after visiting" do
        cell.visit(neighbors.first)
        expect(cell).to be_hall
      end

      it "remembers which neighbor it visits" do
        cell.visit(neighbors.first)
        expect(cell.type).to eq(Cell::WEST)
      end
    end
  end

  context "The start point" do
    let (:cell) { new_cell(Cell::START) }

    it "is the start point" do
      expect(cell).to be_start
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    it "is not affected by visiting" do
      cell.visit(double("Cell"))
      expect(cell).not_to be_visited
    end
  end

  context "The end point" do
    let (:cell) { new_cell(Cell::FINISH) }

    it "is the end point" do
      expect(cell).to be_end
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end

    it "is not affected by visiting" do
      cell.visit(double("Cell"))
      expect(cell).not_to be_visited
    end
  end
end
