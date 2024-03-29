class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authorize
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
  
    def authorize
      if current_user
        unless current_user.can?(params[:controller], params[:action])
          redirect_to login_url, notice: 'You no have permissions to do this.'
        end
      else
        redirect_to login_url, notice: 'Please log in'
      end
    end
end
