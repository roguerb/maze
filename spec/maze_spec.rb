require 'spec_helper'

describe Maze do

  subject(:maze) { build(:maze) }

  it { should respond_to :tiles }
  it { should respond_to :start_point }
  it { should respond_to :end_point }
  it { should respond_to :find }

  describe "#start_point" do
    it { subject.start_point.should be_a_kind_of Tile }
    it { subject.start_point.x.should == 13 }
    it { subject.start_point.y.should == 1 }
  end

  describe "#end_point" do
    it { subject.end_point.should be_a_kind_of Tile }
    it { subject.end_point.x.should == 23 }
    it { subject.end_point.y.should == 7 }
  end

  describe "#find" do
    it { subject.find(0,0).should be_a_kind_of Tile }

    it { subject.find(0,0).type.should == :wall }
    it { subject.find(14,1).type.should == :floor }

    context "when target is the starting point" do
      it { subject.find(13,1).type.should == :start }
    end

    context "when target is the ending point" do
      it { subject.find(23,7).type.should == :end }
    end
  end

end
