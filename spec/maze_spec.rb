require 'spec_helper'

describe Maze do
  subject(:maze) { build(:maze) }

  describe "#start_point" do
    it { subject.start_point.x.should == 13 }
    it { subject.start_point.y.should == 1 }
  end

  describe "#end_point" do
    it { subject.end_point.x.should == 23 }
    it { subject.end_point.y.should == 7 }
  end

  describe "finding tile types" do
    it { subject.tile_type_at(0,0).should == :wall }
    it { subject.tile_type_at(14,1).should == :floor }

    context "when target is the starting point" do
      it { subject.tile_type_at(13,1).should == :start }
    end

    context "when target is the ending point" do
      it { subject.tile_type_at(23,7).should == :end }
    end
  end

  describe "victory conditions" do
    specify do
      subject.end_point?(23,7).should be_true
      subject.end_point?(22,7).should be_false
    end
  end
end
