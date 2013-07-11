module Direction

  class << self
    [:north, :east, :south, :west].each do |direction|
      define_method(direction) do
        direction
      end
    end
  end

end