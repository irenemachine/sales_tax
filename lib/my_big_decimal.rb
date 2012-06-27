require 'bigdecimal'

class BigDecimal
  def tax_round_up
    (self*20).round(0,:up) / 20
  end
end

