require "./spec_helper"

First_chance = 50.percent.chance
Second_chance = 50.percent.chance
Good_chance = 90.percent.chance
Fat_chance = 10.percent.chance # include Sarcasm

describe Chance do

  it "can be created from a Percentage" do
    Percentage.new(20).chance.should be_a(Chance)
  end

  it "has #odds expressed as a Percentage" do
    First_chance.odds.should be_a(Percentage)
  end

  it "should be comparable with another Chance" do
    First_chance.should be > Fat_chance
    First_chance.should eq Second_chance
    First_chance.should be < Good_chance
  end

  # it "should be identical to another very similar Chance" do
  #   begin
  #     same_chance = 50.percent.chance
  #   end while same_chance.happens? != First_chance.happens
  #   First_chance.identical?(same_chance).should be true
  # end

  # it "should not be identical to another slightly different Chance" do
  #   begin
  #     @different_chance = 50.percent.chance
  #   end while @different_chance.happens? == @chance.happens
  #   @chance.identical?(@different_chance).should be false
  # end
  #
  # context "case statement" do
  #   it "renders a single outcome" do
  #     outcome = Chance.case(
  #       70.percent.chance.will {'snow'},
  #       20.percent.chance.will {'sleet'},
  #       8.percent.chance.will {'sun'},
  #       2.percent.chance.will {'knives'}
  #     )
  #     %w(sun sleet snow knives).should include(outcome)
  #   end
  #
  #   it "generally evaluates to the expected outcome with stacked odds" do
  #     outcome = Chance.case(
  #       0.01.percent.chance.will {'rain'},
  #       99.99.percent.chance.will {'sleet'}
  #     )
  #     outcome.should == 'sleet'
  #   end
  #
  #   it "only fires a single case block" do
  #     @count = 0
  #     outcome = Chance.case(
  #       50.percent.chance.will {@count += 1},
  #       50.percent.chance.will {@count += 1}
  #     )
  #     @count.should be 1
  #   end
  #
  #   it "generally follows expected probabilities" do
  #     @heads, @tails = 0, 0
  #     10_000.times do
  #       Chance.case(
  #         50.percent.chance.will {@tails += 1},
  #         50.percent.chance.will {@heads += 1}
  #       )
  #     end
  #     10_000.should == @heads + @tails
  #     (10_000 / 2 - @heads).abs.should be < 200
  #   end
  #
  #   it "should raise if odds add to less than 100" do
  #     lambda {
  #       Chance.case(
  #         10.percent.chance.will {'rain'},
  #         20.percent.chance.will {'sleet'}
  #       )
  #     }.should raise_error
  #   end
  #
  #   it "should raise if odds add to more than 100" do
  #     lambda {
  #       Chance.case(
  #         10.percent.chance.will {'rain'},
  #         20.percent.chance.will {'sleet'},
  #         90.percent.chance.will {'sleet'}
  #       )
  #     }.should raise_error
  #   end
  # end

end