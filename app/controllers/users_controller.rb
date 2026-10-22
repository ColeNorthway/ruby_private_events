class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      cookies.permanent.encrypted[:remember] = user.id
      user.update(remember: cookies.encrypted[:remember])
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.expect(user: [ :username, :password, :password_confirmation ])
  end
end
