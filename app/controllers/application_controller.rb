class ApplicationController < ActionController::Base
  before_action :login_required
  before_action :set_current_user

  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
