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
summ = 0
user_purchases = []
user_choice = nil

until user_choice == 0
  Product.show_list(collection.to_a)
  user_choice = STDIN.gets.to_i

  if (1..collection.to_a.size).include?(user_choice)
    if collection.to_a[user_choice - 1].amount.to_i > 0
      summ += collection.to_a[user_choice - 1].price.to_i
      collection.to_a[user_choice -1].update(amount: collection.to_a[user_choice -1].amount.to_i - 1)
      puts
      puts "Вы выбрали #{collection.to_a[user_choice - 1].to_s}\n"+
           "Всего товаров на сумму - #{summ} руб."
      puts
      user_purchases << collection.to_a[user_choice - 1].to_s
    else
      puts 'Извините товар закончился.'
    end                     
  end

  if user_choice == 0
    if user_purchases.size > 0 
      puts 'Вы купили:'
      user_purchases.each {|purchase| puts purchase}
      puts "C Вас - #{summ} руб."
      puts 'Досвидание.'
    else
      puts 'Досвидание.'
    end
  end
end
