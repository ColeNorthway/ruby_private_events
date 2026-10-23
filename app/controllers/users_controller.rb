class UsersController < ApplicationController
  skip_before_action :authenticate, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.build_user_profile(user_profile)
    if @user.save
      cookies.permanent.encrypted[:remember] = @user.id
      @user.update(remember: cookies.encrypted[:remember])

      flash[:success] = "User Account Created"
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(cookies.encrypted[:remember])
  end

  def update
    @user = User.find(cookies.encrypted[:remember])

    unless check_password_repeat(@user)
      flash.now[:error] = "Cannot change password to currently owned password"
      render :edit, status: :unprocessable_entity and return
    end

    if @user.update(update_params)
      @user.user_profile.update(user_profile)
      flash[:success] = "Successfully updated user profile"
      redirect_to events_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(cookies.encrypted[:remember])
    @user.destroy
    cookies.delete(:remember)
    flash[:success] = "Sorry to see you go!"
    redirect_to events_path
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password, :password_confirmation ])
  end

  def user_profile
    params.expect(user_profile: [ :city, :state, :country, :first_name, :last_name, :gender ])
  end

  def check_password_repeat(user)
    pw_ch = params[:user][:password_challenge]
    pw = params[:user][:password]
    pw_c = params[:user][:password_confirmation]
    if (pw == pw_ch) && (pw == pw_c) && user.authenticate(pw)
      return false
    end

    true
  end

  def update_params
    params.expect(user: [ :username, :password, :password_confirmation, :password_challenge ]).with_defaults(password_challenge: "")
  end
end
