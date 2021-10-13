class Basket
  attr_accessor :products

  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def total_summ
    @products.sum(&:price)
  end

  def show_list
    counter = 0
    @products.tally.map {|prod, quantity| puts "#{counter += 1}. #{prod.to_basket} #{quantity} шт. на сумму #{prod.price.to_i * quantity} руб."}.join("\n")  
  end
end
