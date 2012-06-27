require './lib/exempt_word'
require './lib/item'
require './lib/receipt'

module ShoppingCart
  def self.tokenize_line_item line
    name = line.match(/^\d+ (.*) at \d+\.\d{2}$/)[1].to_s
    class_name = "Item"
    class_name.prepend("Exempt") if ExemptWord.is?(name)
    if name.include? "imported"
      class_name.prepend("Imported")
      name.gsub!(/imported /, "")
    end
    tokens = Hash[
      :count => line.match(/^\d+/).to_s.to_i,
      :price => line.match(/\d+\.\d{2}$/).to_s,
      :name => name,
      :class_object => Kernel.const_get(class_name) ]
  end

  def self.create_and_print_receipt file_name
    raise Exception unless File.readable?(file_name)
    receipt = Receipt.new
    File.open(file_name, "r").each do |line|
      tokens = ShoppingCart.tokenize_line_item(line)
      receipt << tokens[:class_object].new(tokens[:count], tokens[:name], tokens[:price])
    end
    receipt.print
  end
end
