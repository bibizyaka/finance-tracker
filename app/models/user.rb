class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks , through: :user_stocks
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock # if nil then return false
    user_stocks.where(stock_id: stock.id).exists? # checks the stock existance on user_id
  end
  
  def under_stock_limit?
    (user_stocks.count < 10)
  end
  
  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end
  
end #class
