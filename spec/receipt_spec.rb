require 'spec_helper'

describe "Receipt" do
  describe "new" do
    it "should create a new receipt object with no items" do
      receipt = Receipt.new
      receipt.instance_variable_get(:@items).empty?.should be_true
    end
  end
  describe "print" do
    context "it should print one line per item" do
      it "should not print any items if it has no items" do
        receipt = Receipt.new
        STDOUT.should_receive(:puts).exactly(2).times
        receipt.print
      end
      it "should print with one item if it has one item" do
        receipt = Receipt.new
        receipt << Item.new(2, "my name here", "2.99")
        STDOUT.should_receive(:puts).exactly(3).times
        receipt.print
      end
      it "should print with multiple items if it has multiple items" do
        receipt = Receipt.new
        receipt << Item.new(2, "just a plain item", "2.99")
        receipt << ImportedItem.new(1, "item", "2.99")
        receipt << ExemptItem.new(4, "exempt item", "1")
        STDOUT.should_receive(:puts).exactly(5).times
        receipt.print
      end
    end
  end
  describe "<<(item)" do
    it "should throw an exception if item is not an Item object" do
      receipt = Receipt.new
      lambda { receipt << "item" }.should raise_error
    end
    it "should append an Item to @items" do
      receipt = Receipt.new
      receipt << Item.new(1,"item name", "3.99")
      receipt.instance_variable_get(:@items).length.should == 1
      receipt.instance_variable_get(:@items)[0].name.should == "item name"
      receipt.instance_variable_get(:@items)[0].count.should == 1
    end
    it "should update @sales_tax and @total" do
      receipt = Receipt.new
      receipt << Item.new(1,"item name", "3.99")
      receipt.instance_variable_get(:@sales_tax).should == 0.40
      receipt.instance_variable_get(:@total).should == 4.39
    end
  end
end
