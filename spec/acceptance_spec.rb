require_relative "spec_helper"
require "maze"

describe "Acceptance Test" do
  MAZE1 = <<-END_OF_MAZE
#####################################
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
#####################################
  END_OF_MAZE

  MAZE2 = <<-END_OF_MAZE
#####################################
# #       #             #     #     #
# ### ### # ########### ### # ##### #
# #   # #   #   #   #   #   #       #
# # ###A##### # # # # ### ###########
#   #   #     #   # # #   #         #
####### # ### ####### # ### ####### #
#       # #   #       # #       #   #
# ####### # # # ####### # ##### # # #
#       # # # #   #       #   # # # #
# ##### # # ##### ######### # ### # #
#     #   #                 #     #B#
#####################################
  END_OF_MAZE

  MAZE3 = <<-END_OF_MAZE
#####################################
# #   #           #                 #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #  A  #   #       #   # #
# ######### ##### # ####### ### ### #
#               ###       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #   #           #
#####################################
  END_OF_MAZE

  let(:maze1) { Maze.new(MAZE1) }
  let(:maze2) { Maze.new(MAZE2) }
  let(:maze3) { Maze.new(MAZE3) }

  it "determines if a maze is solvable" do
    expect(maze1).to be_solvable
    expect(maze2).to be_solvable
    expect(maze3).not_to be_solvable
  end

  it "counts the steps required to solve the maze" do
    expect(maze1.steps).to eq(44)
    expect(maze2.steps).to eq(75)
  end

  it "returns 0 steps for an unsolveable maze" do
    expect(maze3.steps).to eq(0)
  end
end
