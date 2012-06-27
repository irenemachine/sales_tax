class Receipt

  def initialize
    @sales_tax = 0
    @total = 0
    @items = []

    def <<(item)
      raise Exception unless item.is_a?(Item)
      @items << item
      @total += item.total
      @sales_tax += item.tax
    end
  end

  def print
    @items.each do |item|
      puts "#{item.count.to_s} #{item.name}: %.2f" % item.total
    end
    puts "Sales Taxes: %.2f" % @sales_tax
    puts "Total: %.2f" % @total
  end

end
