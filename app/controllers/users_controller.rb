class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    p "PARAMS"
    p params
    p "PARAMS"
    @user.build_user_profile(user_profile)
    if @user.save
      cookies.permanent.encrypted[:remember] = @user.id
      @user.update(remember: cookies.encrypted[:remember])
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
    params.expect(user: [ :username, :email, :password, :password_confirmation ])
  end

  def user_profile
    params.expect(user_profile: [ :city, :state, :country, :first_name, :last_name, :gender ])
  end
end
