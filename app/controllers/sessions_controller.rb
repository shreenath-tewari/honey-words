class SessionsController < ApplicationController

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
      return redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
