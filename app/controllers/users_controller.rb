class UsersController < ApplicationController
  def teachers
  end
  
  def principals
  end
  
  def specialists
  end
  
  def index
  end
  
  def show
    @user = User.find_by_username(params[:id])
  end
end
