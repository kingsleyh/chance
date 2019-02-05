class Chance
  include Comparable(Float64)

  getter odds : Percentage

  getter happens : Bool

  getter event : Proc(String) = -> { ""}

  # @event : Proc(String) = -> { ""}

  # getter event : Proc(String, String) = Proc.new(String, String)

  def initialize(percent)
    @odds = percent
    @happens = @odds.to_f > Random::Secure.rand(100)
  end

  @@last_chance : Float64 = 0.0

  def self.case(*chances)
    raise "Chances don't add to 100" unless chances.reduce(0) { |sum, chance| sum + chance.to_f } == 100
    ranges = [] of Range(Float64, Float64)
    chances = chances.to_a.sort_by { |c| c.to_f }
    chances.each_with_index do |chance, i|
      chance = chance.to_f

      range =
        if i == 0
          0.0..chance
        elsif i == chances.size - 1
          @@last_chance..100.0
        elsif @@last_chance
          @@last_chance..chance
        end
      if r = range
        @@last_chance = r.begin
        ranges << range
      end
    end

    num = Random::Secure.rand(100)
    ranges.each_with_index do |r, i|
      if r.includes? num
        return chances[i].event.call
      end
    end
  end

  def to_f
    @odds.to_f
  end

  def of(&block)
    yield if happens
  end

  def will(&block : Proc(String))
    @event = block
    self
  end

  def value
    to_f
  end

  def identical(other_chance)
    self == other_chance && self.happens? == other_chance.happens?
  end

  def identical?(other_chance)
    identical(other_chance)
  end

  def happens?
    @happens
  end

  def to_s
    "A #{odds.to_f} percent chance"
  end

  def <=>(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def <=(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def <(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def >(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def >=(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def ==(other : Chance)
    @odds.to_f <=> other.to_f
  end

  def *(other_chance)
    Chance.new(self.odds.of(chance.odds.to_f))
  end
end

# class Chance
#   attr_reader :odds, :happens, :event
#   alias :happens? :happens
#   include Comparable
#
#   def self.case(*chances)
#     raise "Chances don't add to 100" unless chances.inject(0) {|sum, chance| sum + chance.to_f } == 100
#     ranges = []
#     chances = chances.sort_by{|c| c.to_f}
#     chances.each_with_index do |chance, i|
#       chance = chance.to_f
#       range =
#         if i == 0
#           0..chance
#         elsif i == chances.size - 1
#           @last_chance..100
#         elsif @last_chance
#           @last_chance..chance
#         end
#       @last_chance = range.begin
#       ranges << range
#     end
#     num = Kernel.rand(100)
#     ranges.each_with_index do |r, i|
#       if r.include? num
#         return chances[i].event.call
#       end
#     end
#   end
#
#   def initialize(percent)
#     @odds = percent
#     @happens = @odds.to_f > Kernel.rand(100)
#   end
#
#   def of(&block)
#     yield if happens?
#   end
#
#   def will(&block)
#     @event = block
#     self
#   end
#
#   def to_f
#     odds.to_f
#   end
#   alias :value :to_f
#
#   def to_s
#     "A #{odds.to_f} percent chance"
#   end
#
#   def *(other_chance)
#     Chance.new(self.odds.of(chance.odds.to_f))
#   end
#
#   def <=>(other_chance)
#     odds.to_f <=> other_chance.to_f
#   end
#
#   def identical(other_chance)
#     self == other_chance && self.happens? == other_chance.happens?
#   end
#   alias :identical? :identical
#
# end
