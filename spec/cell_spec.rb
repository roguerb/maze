require_relative "spec_helper"
require "maze/cell"

describe Cell do

  context "Any cell" do
    let (:cell) { Cell.new(" ", 3, 4) }

    it "knows its position" do
      expect(cell.position).to eq([3, 4])
    end

    it "knows its neighbor's positions" do
      expect(cell.neighbor_positions.to_a).to eq([[2, 4], [4, 4], [3, 3], [3, 5]])
    end
  end

  context "A wall" do
    let (:cell) { Cell.new("#", 1, 2) }

    it "is a wall" do
      expect(cell).to be_wall
    end

    it "is not traversable" do
      expect(cell).not_to be_traversable
    end
  end

  context "A hall" do
    let (:cell) { Cell.new(" ", 2, 1) }

    it "is a hall" do
      expect(cell).to be_hall
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end
  end

  context "The start point" do
    let (:cell) { Cell.new("A", 3, 2) }

    it "is the start point" do
      expect(cell).to be_start
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end
  end

  context "The end point" do
    let (:cell) { Cell.new("B", 3, 4) }

    it "is the end point" do
      expect(cell).to be_end
    end

    it "is traversable" do
      expect(cell).to be_traversable
    end
  end
end
