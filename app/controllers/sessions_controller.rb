class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create] , unless: -> { Rails.env.production? }

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    hidden_treasure = session[:hidden_treasure]

    reset_session

    session[:user_id] = user.id
    if hidden_treasure
      session[:hidden_treasure] = hidden_treasure
      redirect_to :unearth_treasure
    else
      redirect_to root_url, :notice => 'Signed in!'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
