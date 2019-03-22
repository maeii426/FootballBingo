class HomeController < ApplicationController

    def index
        if params[:email] != nil && params[:password] != nil
            flash[:notice]  = "Login successful"
        else
            redirect_to root_path
        end
    end

end