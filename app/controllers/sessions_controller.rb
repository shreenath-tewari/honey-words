class SessionsController < ApplicationController

  require 'msg91ruby'

  $check_count = 0

  def new
    @c = $check_count
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Login Failed: Invalid Email/Password"
      $check_count += 1
      if($check_count >= 3)
        id = User.find_by(email: params[:session][:email]).id
        phone = User.find(id).phone.to_i
        api = Msg91ruby::API.new("213321AkRBdUcTl5ae8beb9","HPMSGIND")
        api.send(phone, "Test Message", 4)
      end
      return redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
