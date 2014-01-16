class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])   # this is the same as: User.find(1)
  end
  
  def new
  end
end
