class UsersController < ApplicationController #appcontroller needs login method which checks if session token 
    #is same as what user input

    def new
        @user = User.new
        render :new
    end

    def create  #sessio conr=troller needs to have session token
        @user = User.new(user_params)
        if user.save
            redirect_to user_url(user)
        else
            render json: @users.errors.full_messages, status: 422 
        end
    end

    private

    def user_params
        params.require(:user).permit(:username)
    end
end