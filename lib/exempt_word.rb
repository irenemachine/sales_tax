module ExemptWord
  FOOD_WORDS = File.open("./input/foods.csv","r").lines.first.chars.select{|i| i.valid_encoding?}.join.split(',')
  MED_WORDS = File.open("./input/meds.csv","r").lines.first.chars.select{|i| i.valid_encoding?}.join.split(',')
  BOOK_WORDS = ['book']

  def self.is?(name)
    name.downcase.split.each do |word|
      return true if FOOD_WORDS.member?(word) or BOOK_WORDS.member?(word) or MED_WORDS.member?(word)
      word = word[0..-2]
      return true if FOOD_WORDS.member?(word) or BOOK_WORDS.member?(word) or MED_WORDS.member?(word)
      word = word[0..-2]
      return true if FOOD_WORDS.member?(word) or BOOK_WORDS.member?(word) or MED_WORDS.member?(word)
    end
    false
  end
end
