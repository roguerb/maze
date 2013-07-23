class Cell
  def initialize(cell_type, x, y)
    @type = cell_type
    @x = x
    @y = y
  end

  def position
    [@x, @y]
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
