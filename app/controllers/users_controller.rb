class UsersController < ApplicationController
  
  def my_portfolio 
    @user = current_user
    @user_stocks = current_user.stocks
  end
  
  def my_friends
    
    @friendships = current_user.friends
    
  end
  
  def search
    # puts params[:search_param]
    # @users = User.search(params[:search_param])
    # render json: @users
    
    if params[:search_param].blank?
      flash.now[:danger]="Friend name cannot be blank"
    else
      @users = User.search(params[:search_param]) 
      @users = current_user.except_current_user(@users)
      flash.now[:danger]="User not found..." if @users.blank?
    end
    respond_to do |format|
      format.js {render partial: 'friends/result'} 
    end
  
  end #search
  
  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success]="Friend was added successfully"
    else
      flash[:danger]="There was a problem with saving the user"
    end
    redirect_to my_friends_path
    
  end
  
  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks # that firend of ours and hist stocks now
  end
  
end #class
