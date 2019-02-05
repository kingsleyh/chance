class Percentage
  include Comparable(Int32 | Float32 | Float64)

  getter value : Int32 | Float32 | Float64

  def initialize(@value : Int32 | Float32 | Float64)
  end

  def of(number_or_percentage)
    number_or_percentage * (value / 100.0)
  end

  def chance
    Chance.new self
  end

  def to_f
    @value.to_f
  end

  def to_s
    to_f.to_s
  end

  def <=>(other : Percentage)
    @value <=> other.value
  end

  def <=(other : Percentage)
    @value <=> other.value
  end

  def <(other : Percentage)
    @value <=> other.value
  end

  def >(other : Percentage)
    @value <=> other.value
  end

  def >=(other : Percentage)
    @value <=> other.value
  end

  def ==(other : Percentage)
    @value <=> other.value
  end

  def *(other : Percentage | Int32 | Float32 | Float64)
    other_value = other.is_a?(Percentage) ? other.value : other
    Percentage.new value * other_value
  end

end
