class Basket
  attr_accessor :products

  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def total_summ
    summ = 0
    @products.each {|prod| summ += prod[:price]}
    return summ
  end

  def show_list
    counter = 0
    result =
      @products.tally.map {|prod, quantity| "#{counter +=1}. #{prod[:title]} #{quantity} шт. на сумму #{prod[:price] *quantity} руб."}.join("\n")               
  end
end
