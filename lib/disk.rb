# encoding: utf-8
#
# Класс Диск
class Disk < Product
  attr_accessor :title, :genre, :author, :year

  # Метод класса from_file считывает данные о книге из файла, путь к которому
  # ему передали в качестве параметра и передает их на вход своему же
  # конструктору с нужными ключами.
  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      genre: lines[2],
      author: lines[1],
      price: lines[4],
      amount: lines[5],
      year: lines[3]
    )
  end

  def initialize(params)
    super

    @title = params[:title]
    @genre = params[:genre]
    @author = params[:author]
    @year = params[:year]
  end

  def to_s
    "Альбом «#{@title}» - #{@author}, #{@genre}, #{@year}, #{super}"
  end

  def to_basket
    "Альбом «#{@title}» - #{@author}, #{@genre}, #{@year}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end
end
