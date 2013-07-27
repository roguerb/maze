require_relative "spec_helper"
require "maze/path"

describe Path do
  context "An empty path" do
    let(:path) { Path.new }

    it "is not complete" do
      expect(path).not_to be_complete
    end

    it "has no steps" do
      expect(path.steps).to eq(0)
    end

    it "has no current cell" do
      expect(path.current_cell).to be_nil
    end
  end

  context "A path" do
    let(:cells) { Array.new(3) { double("Cell") } }
    let(:path) { Path.new(*cells) }

    it "has one less step than its cell count" do
      expect(path.steps).to eq(2)
    end

    it "treats its last cell as its current_cell" do
      expect(path.current_cell).to be(cells.last)
    end

    it "can be drawn" do
      expect(cells[0]).to receive(:visit).with(cells[1])
      expect(cells[1]).to receive(:visit).with(cells[2])

      path.draw
    end
  end

  context "An incomplete path" do
    let(:cells) { Array.new(3) { double("Cell", :end? => false) } }
    let(:path) { Path.new(*cells) }

    it "is not complete" do
      expect(path).not_to be_complete
    end
  end

  context "A complete path" do
    let(:path) { Path.new(double("Cell", :end? => false), double("Cell", :end? => true)) }

    it "is complete" do
      expect(path).to be_complete
    end
  end

  context "A partial path" do
    before(:each) do
      @neighbors = Array.new(2) { double("Cell") }
      @cell = double("Cell", :traversable_neighbors => @neighbors)
      @path = Path.new(@cell)
    end

    it "generates one successor per neighbor" do
      expect(@path.successors.size).to eq(@neighbors.size)
    end

    it "appends each neighbor to a successor" do
      @path.successors.zip(@neighbors) do |successor, neighbor|
        expect(successor.current_cell).to be(neighbor)
      end
    end

    it "doesn't change itself when generating successors" do
      before = @path.steps
      @path.successors
      expect(@path.steps).to eq(before)
    end
  end

  context "With an already-visited neighbor" do
    it "doesn't generate successors" do
      visited = double("Visited")
      cell = double("Cell", :traversable_neighbors => [visited])
      path = Path.new(visited, cell)

      expect(path.successors.to_a).to be_empty
    end
  end
end
