require 'spec_helper'

describe Marker do

  let(:tile_double) { OpenStruct.new({x: 10, y: 12}) }
  subject(:marker) { Marker.new(tile_double) }

  it "can be initialized" do
    marker.should be_an_instance_of(Marker)
    expect(marker.x).to eq(10)
    expect(marker.y).to eq(12)
  end

  it { should respond_to :x }
  it { should respond_to :y }

end
