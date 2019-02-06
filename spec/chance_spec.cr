require "./spec_helper"

First_chance  = Chance(Nil).new(50.percent)
Second_chance = Chance(Nil).new(50.percent)
Good_chance   = Chance(Nil).new(90.percent)
Fat_chance    = Chance(Nil).new(10.percent) # include Sarcasm

describe Chance do
  it "can be created from a Percentage" do
    Chance(Nil).new(Percentage.new(20)).should be_a(Chance(Nil))
  end

  it "has #odds expressed as a Percentage" do
    First_chance.odds.should be_a(Percentage)
  end

  it "should be comparable with another Chance" do
    First_chance.should be > Fat_chance
    First_chance.should eq Second_chance
    First_chance.should be < Good_chance
  end

  it "should be identical to another very similar Chance" do
    same_chance = Chance(Nil).new(50.percent)
    while same_chance.happens? != First_chance.happens
      same_chance = Chance(Nil).new(50.percent)
    end
    First_chance.identical?(same_chance).should be_true
  end

  it "should not be identical to another slightly different Chance" do
    different_chance = Chance(Nil).new(50.percent)
    while different_chance.happens? == First_chance.happens
      different_chance = Chance(Nil).new(50.percent)
    end
    First_chance.identical?(different_chance).should be_false
  end

  it "should work with of" do
    Chance(String).new(100.percent).of {"rain"}.should eq("rain")
  end

  describe "case statement" do
    it "renders a single outcome" do
      outcome = Chance.case(
        Chance(String).new(70.percent).will { "snow" },
        Chance(String).new(20.percent).will { "sleet" },
        Chance(String).new(8.percent).will { "sun" },
        Chance(String).new(2.percent).will { "knives" }
      )
      %w(sun sleet snow knives).should contain(outcome)
    end

    it "should raise if odds add to less than 100" do
      expect_raises(Exception, "Chances don't add to 100") {
        Chance.case(
          Chance(String).new(10.percent).will { "rain" },
          Chance(String).new(20.percent).will { "sleet" }
        )
      }
    end

    it "should raise if odds add to more than 100" do
      expect_raises(Exception, "Chances don't add to 100") {
        Chance.case(
          Chance(String).new(10.percent).will { "rain" },
          Chance(String).new(20.percent).will { "sleet" },
          Chance(String).new(90.percent).will { "wind" }
        )
      }
    end

    # This test will only pass 99.99% of the time!!
    it "generally evaluates to the expected outcome with stacked odds" do
      outcome = Chance.case(
        Chance(String).new(0.01.percent).will { "rain" },
        Chance(String).new(99.99.percent).will { "sleet" }
      )
      outcome.should eq("sleet")
    end

    it "only fires a single case block" do
      count = 0
      outcome = Chance.case(
        Chance(Int32).new(50.percent).will { count += 1 },
        Chance(Int32).new(50.percent).will { count += 1 }
      )
      count.should eq(1)
    end

    it "generally follows expected probabilities" do
      heads, tails = 0, 0
      10_000.times do
        Chance.case(
          Chance(Int32).new(50.percent).will { tails += 1 },
          Chance(Int32).new(50.percent).will { heads += 1 }
        )
      end
      10_000.should eq(heads + tails)
      (10_000 / 2 - heads).abs.should be <= 200
    end
  end
end
