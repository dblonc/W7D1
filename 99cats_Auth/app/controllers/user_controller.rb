class UsersController < ApplicationController

    def show
        @users = User.all 
        render :show

    end

    def new
        @user = User.new(user_params)
        render :new

    end

    def create
        @user = User.new(user_params)
        if user.save
            render :new
        else
            render :json @users.errors.full_messages, status: 422 
        end
        render :new

    end

    private

    def user_params
        params.require(:@users).permit(:username)
    end


end