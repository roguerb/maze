require 'spec_helper'

describe Marker do
  let(:x) { 10 }
  let(:y) { 12 }

  context "with an x and a y" do
    subject(:marker) { Marker.new(x, y) }

    it "can be initialized" do
      marker.should be_an_instance_of(Marker)
      expect(marker.x).to eq(10)
      expect(marker.y).to eq(12)
    end
  end

  context "with an x but no y" do
    describe "#new" do
      it "requires both arguments" do
        expect { Marker.new(x) }.to raise_error
      end
    end
  end
end