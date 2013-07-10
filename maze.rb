class Point
  attr_accessor :x, :y, :tile

  def initialize(tile, x, y)
    @x = x
    @y = y
    @tile = tile
  end
end

class Player
  attr_accessor :x, :y

  def initialize(point)
    x = point.x
    y = point.y
  end

  def up
    x += 1
  end

end

class Maze
  attr_accessor :maze

  MAZE1 = %{#####################################
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
#####################################}
  
  def initialize
    @maze = parse_maze(MAZE1)
    @player = Player.new(start_point)
  end

  def find(x, y)
    @maze.select { |v| v.x == x && v.y == y }.first
  end

  def start_point
    @maze.select { |v| v.type == "A".to_sym }.first
  end

  def end_point
    @maze.select { |v| v.type == "B".to_sym }.first
  end

private
  def parse_maze(maze)
    x = 0
    y = 0
    result = []

    maze.each_char do |char|
      if char == "\n"
        y += 1
        x = 0
      else 
       result << Point.new(char.to_sym, x, y)
       x += 1 
      end
    end 
    result
  end
end
