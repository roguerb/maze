class Path
  def initialize(*cells)
    @cells = cells
  end

  def current_cell
    @cells.last
  end

  def with(cell)
    self.class.new(*(@cells + [cell]))
  end

  def include?(cell)
    @cells.include?(cell)
  end

  def complete?
    current_cell && current_cell.end?
  end

  def steps
    @cells.empty? ? 0 : @cells.size - 1
  end

  def positions
    @cells.collect(&:position)
  end
end
