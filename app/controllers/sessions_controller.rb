class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
  end

  def create
    # Create a session on login
    user = User.find_by(username: params[:name])
    user = User.find_by(email: params[:name]) if user.nil?

    if user&.authenticate(params[:password])
      cookies.permanent.encrypted[:remember] = user.id
      user.update(remember: cookies.encrypted[:remember])

      flash[:success] = "Welcome Back #{user.username}"
      redirect_to events_path
    else
      flash.now[:error] = "Error invalid username or password"
      render :new, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(id: cookies.encrypted[:remember])
    cookies.delete(:remember)
    user&.update(remember: nil)

    flash[:success] = "Successfully Logged Off"
    redirect_to events_path
  end
end
