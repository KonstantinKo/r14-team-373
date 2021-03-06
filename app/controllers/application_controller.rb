class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :chewy_atomic

  def chewy_atomic
    Chewy.atomic do
      yield
    end
  end

  helper_method :current_user
  helper_method :user_signed_in?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def authenticate_user!
      if !current_user
        redirect_to signin_path, :alert => 'You need to sign in for access to this page.'
      end
    end

end
