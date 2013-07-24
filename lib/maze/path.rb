class Path
  def initialize(*cells)
    @cells = cells
  end

  def current_cell
    @cells.last
  end

  def successors(&block)
    current_cell.traversable_neighbors.reject {
        |neighbor| include?(neighbor)
    }.collect {
        |neighbor| with(neighbor)
    }.each(&block)
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

  def to_s
    @cells.join(', ')
  end

  private

  def with(cell)
    self.class.new(*(@cells + [cell]))
  end
end
