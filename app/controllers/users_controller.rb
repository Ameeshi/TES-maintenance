class UsersController < ApplicationController
  def teachers
    @teachers = User.with_role :teacher
  end
  
  def principals
    @principals = User.with_role :principal
  end
  
  def specialists
    @specialists = User.with_role :specialist
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by_username(params[:id])
    
    @result_array = [10, 4, 8, 9, 13]
  end
end
