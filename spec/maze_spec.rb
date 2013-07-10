require 'spec_helper'

describe Maze do

  let(:maze_string) { %{#####################################
# #   #     #A        #     #       #
# # # # # # ####### # ### # ####### #
# # #   # #         #     # #       #
# ##### # ################# # #######
#     # #       #   #     # #   #   #
##### ##### ### ### # ### # # # # # #
#   #     #   # #   #  B# # # #   # #
# # ##### ##### # # ### # # ####### #
# #     # #   # # #   # # # #       #
# ### ### # # # # ##### # # # ##### #
#   #       #   #       #     #     #
#####################################} }

  subject(:maze) { Maze.new(maze_string) }

  it { respond_to :maze }
  it { respond_to :start_point }
  it { respond_to :end_point }
  it { respond_to :find }

  describe "#start_point" do
    it { subject.start_point.should be_a_kind_of Point }
    it { subject.start_point.x.should == 13 }
    it { subject.start_point.y.should == 1 }
  end

  describe "#end_point" do
    it { subject.end_point.should be_a_kind_of Point }
    it { subject.end_point.x.should == 23 }
    it { subject.end_point.y.should == 7 }
  end

  describe "#find" do
    it { subject.find(0,0).tile.should == "#"}
    it { subject.find(13,1).tile.should == "A"}
    it { subject.find(23,7).tile.should == "B"}
    it { subject.find(1,1).tile.should == " "}
  end

end