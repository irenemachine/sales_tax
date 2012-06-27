require 'bigdecimal'
require './lib/my_big_decimal'

class Item
  attr_reader :total, :tax, :count, :name

  def initialize count, name, price
    raise Exception unless count.is_a?(Integer) and count > 0
    raise Exception unless name.is_a?(String) and name.length > 0
    raise Exception unless price.is_a?(String) and price.to_f > 0

    @count = count
    @name = name
    subtotal = BigDecimal.new(price)*count
    @tax = (subtotal*self.tax_rate).tax_round_up
    @total = subtotal + @tax
  end

  def tax_rate
    BigDecimal.new("0.1")
  end
end

class ExemptItem < Item
  def tax_rate
    BigDecimal.new("0.0")
  end
end

class ImportedItem < Item
  def tax_rate
    BigDecimal.new("0.15")
  end

  def name
    "imported " + @name
  end
end

class ImportedExemptItem < ImportedItem
  def tax_rate
    BigDecimal.new("0.05")
  end
end
