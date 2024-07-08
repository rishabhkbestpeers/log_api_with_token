class AccountController < ApplicationController

    skip_forgery_protection

    def index

       @user= Account.find_by_token(params[:token])
       
       if @user == nil
          render json: {"message":"please Enter the valid token"}
       elsif @user.token != nil
          render json: {"message":"Logged in Username is #{@user.username}"}
       else        
          render json: {"message":"No user is logged in"}
       end
    end


    def create

        #for registering the account 
        @account = Account.new(signup_params)
        if @account.save
            render json: @account
        else
            render :json => { :errors => @account.errors.full_messages }
        end

    end

    private

    def signup_params
        params.require(:account).permit(:username,:email,:password)
    end
end
