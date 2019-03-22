class AccountsController < ApplicationController
  
  def account_params
    params.require(:user, :email).permit(:name, :password) # company, (school-year,major,etc.)
  end

  def login

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
