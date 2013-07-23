class Cell
  def initialize(cell_type, x, y)
    @type = cell_type
    @x = x
    @y = y
  end

  def position
    [@x, @y]
  end

  def neighbor_positions(&block)
    [[@x - 1, @y], [@x + 1, @y], [@x, @y - 1], [@x, @y + 1]].each(&block)
  end

  def traversable?
    !wall?
  end

  def wall?
    @type == "#"
  end

  def hall?
    @type == " "
  end

  def start?
    @type == "A"
  end

  def end?
    @type == "B"
  end
end
