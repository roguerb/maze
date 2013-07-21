class Maze
  def initialize(maze_string)
    parse(maze_string)
  end

  def solvable?
    false
  end

  def steps
    0
  end

  def at(x, y)
    return nil unless (0...@cells.size).include?(y)
    row = @cells[y]
    return nil unless (0...row.size).include?(x)
    row[x]
  end

  private

  def parse(maze_string)
    @cells = maze_string.lines.map(&:chomp).to_a
  end
end
