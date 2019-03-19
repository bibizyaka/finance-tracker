class UserStocksController < ApplicationController
  def create
    # save stock to Stock table if not present already
    stock = Stock.find_by_ticker(params[:stock_ticker]) 
    if stock.blank? # couldn't find the stock in my table
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    # Now we will create association between user and that saves stock that we added
    @user_stock = UserStock.create(user:current_user, stock: stock)
    flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  
  end #create
  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy # deletes from the table as well
    flash[:notice] = "Stock was removed successfully"
    redirect_to my_portfolio_path
    
  end
end
