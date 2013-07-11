require 'spec_helper'

describe Marker do
  it "can be initialized" do
    point_double = OpenStruct.new({x: 10, y: 12})
    marker = Marker.new(point_double)

    marker.should be_an_instance_of(Marker)
    expect(marker.x).to eq(10)
    expect(marker.y).to eq(12)
  end

  it { respond_to :x }
  it { respond_to :y }
  it { respond_to :maze }
end