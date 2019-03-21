class UsersController < ApplicationController
  
  def user_params
    params.require(:user, :email).permit(:name, :password) # company, (school-year,major,etc.)
  end

  def login
    # does password match username?
  end

  def new
    # default: render 'new' template
  end

  def create
      
  end

  def edit

  end

  def update

  end

  def destroy

  end

end
