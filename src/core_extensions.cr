struct Int32
  def percent
    Percentage.new(self)
  end
end

struct Float32
  def percent
    Percentage.new(self)
  end
end

struct Float64
  def percent
    Percentage.new(self)
  end
end
