require 'securerandom'

class LoginController < ApplicationController
  skip_forgery_protection

  def new
    usnme = params[:account][:username]
    pss = params[:account][:password]
    @user = Account.find_by_username(usnme)

    if @user.token != nil
      render json:{"message":"user is already logged in please logout first"}
      return
    else
      if @user==nil
        render json:{"message":"can't find the username pleaselogin with valid email or password"}
      else
        if @user.password==pss
            random_string = SecureRandom.hex
            @user.token = random_string;
            @user.save;
            render json: {"token":"#{random_string}","message":"User logged in succesfully"}  
        else
            render plain: "Invalid email or password"
        end
      end
    end
  end

  def destroy
    @token = params[:token]
    if Account.find_by_token(@token)
      @user = Account.find_by_token(@token);
      @user.token = nil
      @user.save
      render json: { "message":" #{@user.username} logged out successfully"}
    else
      render plain: "Please login first"
    end
  end

  private

  def fetch_username
    params.require(:account).permit(:username)
  end
  def fetch_password
    params.require(:account).permit(:password)
  end
end
