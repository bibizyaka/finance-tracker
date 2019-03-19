class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.new_from_lookup(ticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol) 
      # because we need 3 attrributes from stock quote out of many we will create new sotck object
      return new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
      # that new method constructs new object and sends it back to the caller
    rescue Exception => e
      return nil
    end
  end #new_from_lookup
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

end #class
