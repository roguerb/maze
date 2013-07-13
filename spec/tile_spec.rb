require 'spec_helper'

describe Tile do
  it "can be initialized" do
    tile = Tile.new('#', 1, 3)

    tile.should be_an_instance_of(Tile)
    expect(tile.x).to eq(1)
    expect(tile.y).to eq(3)
  end

  it { respond_to :x }
  it { respond_to :y }
  it { respond_to :type }
end
