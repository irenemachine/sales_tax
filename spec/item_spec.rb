require 'spec_helper'

describe "Item" do
  describe "new" do
    it "should raise an exception if no input is given" do
      lambda {item = Item.new}.should raise_error
    end
    it "should raise an exception if invalid input is given" do
      lambda {item = Item.new -2, "my name here", "2.99"}.should raise_error
      lambda {item = Item.new "2", "my name here", "2.99"}.should raise_error
      lambda {item = Item.new 0, "my name here", "2.99"}.should raise_error

      lambda {item = Item.new 2, "", "2.99"}.should raise_error
      lambda {item = Item.new 2, 4, "2.99"}.should raise_error

      lambda {item = Item.new 2, "my name here"}.should raise_error
      lambda {item = Item.new 2, "my name here", "-2.99"}.should raise_error
      lambda {item = Item.new 2, "my name here", 2.99}.should raise_error
    end
    it "should create an item if count, name, and base_price is given" do
      item = Item.new 2, "my name here", "2.99"
      item.is_a?(Item).should be_true
      item.count.should == 2
      item.name.should == "my name here"
    end
    it "should set tax and total based on count, base_price and tax_rate" do
      item = Item.new 2, "my name here", "2.99"
      item.tax.should == 0.60
      item.total.should == 6.58
    end
    it "should round tax up to the closest nickel" do
      item = ImportedItem.new 1, "name", "3.21"
      item.tax.should == 0.50
    end
  end
  describe "tax_rate" do
    it "should return a BigDecimal with value 0.10" do
      Item.new(1, "name", "2.99").tax_rate.should == 0.1
    end
  end
end

describe "ImportedItem" do
  describe "new" do
    it "should create an imported item inherited from Item" do
      item = ImportedItem.new 2, "imported name", "2.99"
      item.is_a?(ImportedItem).should be_true
      item.is_a?(Item).should be_true
    end
    it "should set tax and total based on count, base_price and tax_rate" do
      item = ImportedItem.new 1, "imported name", "2.99"
      item.tax.should == 0.45
      item.total.should == 3.44
    end
  end
  describe "name" do
    it "should format the name to begin with 'imported'" do
      ImportedItem.new(1, "name", "2.99").name.should == "imported name"
    end
  end
  describe "tax_rate" do
    it "should return a BigDecimal with value 0.15" do
      ImportedItem.new(1, "imported name", "2.99").tax_rate.should == 0.15
    end
  end
end

describe "ExemptItem" do
  describe "new" do
    it "should create an exempt item inherited from Item" do
      item = ExemptItem.new 2, "exempt name", "2.99"
      item.is_a?(ExemptItem).should be_true
      item.is_a?(Item).should be_true
    end
    it "should set tax and total based on count, base_price and tax_rate" do
      item = ExemptItem.new 1, "name", "2.99"
      item.tax.should == 0.00
      item.total.should == 2.99
    end
  end
  describe "tax_rate" do
    it "should return a BigDecimal with value 0.0" do
      ExemptItem.new(1, "imported name", "2.99").tax_rate.should == 0.0
    end
  end
end

describe "ImportedExemptItem" do
  describe "new" do
    it "should create an imported exempt item inherited from Item" do
      item = ImportedExemptItem.new 2, "exempt name", "2.99"
      item.is_a?(ImportedExemptItem).should be_true
      item.is_a?(Item).should be_true
    end
    it "should set tax and total based on count, base_price and tax_rate" do
      item = ImportedExemptItem.new 1, "imported name", "2.99"
      item.tax.should == 0.15
      item.total.should == 3.14
    end
  end
  describe "tax_rate" do
    it "should return a BigDecimal with value 0.05" do
      ImportedExemptItem.new(1, "imported name", "2.99").tax_rate.should == 0.05
    end
  end
end

