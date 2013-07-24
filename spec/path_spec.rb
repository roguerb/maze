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

  context "An incomplete path" do
    let(:cells) { Array.new(3) { double("Cell", :end? => false) } }
    let(:path) { Path.new(*cells) }

    it "is not complete" do
      expect(path).not_to be_complete
    end

    it "has one less step than its cell count" do
      expect(path.steps).to eq(2)
    end

    it "treats its last cell as its current_cell" do
      expect(path.current_cell).to be(cells.last)
    end
  end

  context "A complete path" do
    let(:path) { Path.new(double("Cell", :end? => false), double("Cell", :end? => true)) }

    it "is complete" do
      expect(path).to be_complete
    end
  end

  context "An extended path" do
    before(:each) do
      @path = Path.new
      @cell = double("Cell")
      @extended_path = @path.with(@cell)
    end

    it "includes the extension" do
      expect(@extended_path).to include(@cell)
    end

    it "is a different object from its original" do
      expect(@extended_path).not_to be(@path)
    end
  end
end
