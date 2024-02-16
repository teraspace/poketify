class ApplicationController < ActionController::Base

  before_action :set_current_user
  before_action :protected_pages

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def protected_pages
    redirect_to new_session_path unless Current.user
  end
end
