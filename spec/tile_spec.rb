require 'spec_helper'

describe Tile do
  context "with valid arguments" do
    let(:tile) { Tile.new('#', 1, 3) }

    it "can be initialized" do
      expect(tile.type).to eq("#")
      expect(tile.x).to eq(1)
      expect(tile.y).to eq(3)
    end
  end

  context "with insufficient arguments" do
    it "won't initialize" do
      expect { Tile.new }.to raise_error
    end
  end
end
