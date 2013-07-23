class Cell
  def initialize(cell_type)
    @type = cell_type
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
