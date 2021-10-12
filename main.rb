# encoding: utf-8
#
# Программа-магазин книг и фильмов. Версия 0.5 — с классом ProductCollection,
# который умеет хранить и сортировать коллекцию любых продуктов.
#
# (с) goodprogrammer.ru
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disk'
require_relative 'lib/basket'
# Подключаем класс ProductCollection
require_relative 'lib/product_collection'

# Создаем коллекцию продуктов, передавая методу класса from_dir путь к папке
# с подпапками films и books. ProductCollection сам знает, как там внутри лежат
# эти файлы, и сам разберется, как их оттуда считать.
collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

# Сортируем продукты по возрастанию цены с помощью метода sort! экземпляра
# класса ProductCollection
collection.sort!(by: :price, order: :asc)

# Получаем массив продуктов методом to_a и выводим каждый на экран, передавая
# его методу puts в качестве аргумента.
user_choice = nil
user_basket = Basket.new

until user_choice == 0
  puts Product.show_list(collection.to_a)
  user_choice = STDIN.gets.to_i
  prod_index = user_choice - 1

  if (1..collection.to_a.size).include?(user_choice)  
    collection.to_a[prod_index].update(amount: collection.to_a[prod_index].amount.to_i - 1)
    user_basket.add_product({title: collection.to_a[prod_index].to_basket,  
                            price: collection.to_a[prod_index].price.to_i})
    puts
    puts user_basket.show_list
    puts                    
  end

  if user_choice.zero?
    if user_basket.empty? 
      puts 'Досвидание.'
    else
      puts
      puts user_basket.show_list.gsub('В вашей корзине:', 'Вы приобрели:').gsub('Итого к оплате:', 'Итого на сумму:')
      puts
      puts 'Досвидание.'
    end
  end
end
