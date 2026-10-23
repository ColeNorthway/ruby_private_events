class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate
  before_action :auth_state

  protected

  def get_user_via_sess
    user = User.find_by(id: cookies.encrypted[:remember])
  end

  def update_user_remember(user)
    user.update(remember: cookies.encrypted[:remember])
  end

  def set_user_cookie(user)
    cookies.permanent.encrypted[:remember] = user.id
  end

  private

  def authenticate
    unless logged_in?
      flash[:error] = "Error you need to be signed in to view that"
      redirect_to events_path
    end
  end

  def auth_state
    @logged_in = logged_in? ? true : false
  end

  def logged_in?
    return false if cookies.encrypted[:remember].nil?

    user = User.find_by(id: cookies.encrypted[:remember])
    return false if user.nil?

    p "User Remember: #{user.remember} ----- Cookies Remember: #{cookies.encrypted[:remember]}"

    return false if user.remember != cookies.encrypted[:remember]
    true
  end
end
