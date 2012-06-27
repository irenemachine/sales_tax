require 'spec_helper'

describe "BigDecimal" do
  describe "tax_round_up" do
    it "shoud return self if already a nickel" do
      BigDecimal.new("0.15").tax_round_up.should == 0.15
    end
    it "should round up to the closest nickel" do
      BigDecimal.new("0.17").tax_round_up.should == 0.2
    end
  end
end
