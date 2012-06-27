require './lib/shopping_cart'

ARGV[0] == "--help" ? File.open("README","r").each{|l| puts l} : ShoppingCart.create_and_print_receipt(ARGV[0])

