class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to login_url, notice: 'Invalid user/password combination'
    end
  end

  # DELETE /logout
  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Logged out'
  end
end