class Basket

  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def empty?
    if @products.empty?
      true
    else
      false
    end
  end

  def show_list
    total_products = @products.uniq
    str = ""
    summ = 0

    total_products.each_with_index do |product, index|
      quantity = @products.count(product)
      str += "#{index + 1}. #{product[:title]}, #{quantity} шт. на сумму #{product[:price] * quantity} руб.\n" 
      summ += product[:price] * quantity
    end

    result_str = "В вашей корзине:\n#{str}\nИтого к оплате: #{summ} руб."
                     
  end
end
