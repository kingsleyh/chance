require "./spec_helper"

describe Percentage do
  it "can be created from an Integer" do
    20.should eq(Percentage.new(20).value)
  end

  it "can be created from a Float" do
    20.0.should eq(Percentage.new(20.0).value)
  end

  it "is comparable to other Percentages" do
    Percentage.new(20).should eq Percentage.new(20)
    Percentage.new(10).should be < Percentage.new(15)
    Percentage.new(15).should be > Percentage.new(10)
  end

  it "can get a Percentage of a number" do
    result = 50.percent.of 50
    result.should eq(25)
  end

  it "can get a Percentage of a float" do
    result = 50.0.percent.of 50.0
    result.should eq(25.0)
  end

  it "can get a Percentage of a Percentage" do
    result = 25.percent.of 90.percent
    result.should eq 22.5.percent
  end

  it "can get percentage as a string" do
    25.percent.to_s.should eq("25.0")
  end

  it "can get percentage as a float" do
    25.percent.to_f.should eq(25.0)
  end

  it "should return a chance" do
    
  end
end
