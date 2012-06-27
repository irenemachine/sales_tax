require 'spec_helper'

describe "ShoppingCart" do
  describe "create_and_print_receipt" do
    it "input1" do
      STDOUT.should_receive(:puts).with("1 book: 12.49")
      STDOUT.should_receive(:puts).with("1 music CD: 16.49")
      STDOUT.should_receive(:puts).with("1 chocolate bar: 0.85")
      STDOUT.should_receive(:puts).with("Sales Taxes: 1.50")
      STDOUT.should_receive(:puts).with("Total: 29.83")

      ShoppingCart.create_and_print_receipt "./input/input1.txt"
    end

    it "input2" do
      STDOUT.should_receive(:puts).with("1 imported box of chocolates: 10.50")
      STDOUT.should_receive(:puts).with("1 imported bottle of perfume: 54.65")
      STDOUT.should_receive(:puts).with("Sales Taxes: 7.65")
      STDOUT.should_receive(:puts).with("Total: 65.15")

      ShoppingCart.create_and_print_receipt "./input/input2.txt"
    end

    it "input3" do
      STDOUT.should_receive(:puts).with("1 imported bottle of perfume: 32.19")
      STDOUT.should_receive(:puts).with("1 bottle of perfume: 20.89")
      STDOUT.should_receive(:puts).with("1 packet of headache pills: 9.75")
      STDOUT.should_receive(:puts).with("1 imported box of chocolates: 11.85")
      STDOUT.should_receive(:puts).with("Sales Taxes: 6.70")
      STDOUT.should_receive(:puts).with("Total: 74.68")

      ShoppingCart.create_and_print_receipt "./input/input3.txt"
    end

    it "should raise exception is file is not valid" do
      lambda { ShoppingCart.create_and_print_receipt "" }.should raise_error
    end
  end
  describe "tokenize_line_item" do
    it "should raise an exception if the input is not a string" do
      lambda { ShoppingCart.tokenize_line_item(5) }.should raise_error
    end
    it "should raise an exception if the input is not the correct format" do
      lambda { ShoppingCart.tokenize_line_item("This is not the correct format") }.should raise_error
    end
    context "should return a hash with accurate count, price, name, and class_object" do
      it "should detect an item" do
        tokens = ShoppingCart.tokenize_line_item "2 music CDs at 3.99"
        tokens[:count].should == 2
        tokens[:price].should == "3.99"
        tokens[:name].should == "music CDs"
        tokens[:class_object].should == Kernel.const_get("Item")
      end
      it "should detect an imported item" do
        tokens = ShoppingCart.tokenize_line_item "1 imported music CDs at 3.99"
        tokens[:count].should == 1
        tokens[:price].should == "3.99"
        tokens[:name].should == "music CDs"
        tokens[:class_object].should == Kernel.const_get("ImportedItem")
      end
      it "should detect an exempt item" do
        tokens = ShoppingCart.tokenize_line_item "1 shrimp at 0.99"
        tokens[:count].should == 1
        tokens[:price].should == "0.99"
        tokens[:name].should == "shrimp"
        tokens[:class_object].should == Kernel.const_get("ExemptItem")
      end
      it "should detect an imported and exempt item" do
        tokens = ShoppingCart.tokenize_line_item "1000 imported shrimp at 0.99"
        tokens[:count].should == 1000
        tokens[:price].should == "0.99"
        tokens[:name].should == "shrimp"
        tokens[:class_object].should == Kernel.const_get("ImportedExemptItem")
      end
    end
  end
end
