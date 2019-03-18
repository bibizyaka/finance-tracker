class StocksController < ApplicationController
  
  def search
    if params[:stock].blank?
      flash.now[:danger]="Stock name can't be blank"
    else
      @stock = Stock.new_from_lookup(params[:stock]) 
      flash.now[:danger] = "Stock not found..." unless @stock
    end
    respond_to do |format|
      format.js {render partial: 'users/result'}
    end
  end
  
end #class