class SessionsController < ApplicationController
  # force_ssl
  # possibly re-enable when Openshift supports custom SSL certificates

  def new
    set_page nil, 'Log In', 'Log In', nil
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'Welcome back, ' + user.name + '!'
    else
      flash.now[:alert] = 'That email and password combination does not exist in our records'
      set_page nil, 'Log In', 'Log In', nil
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "You've logged out. See you later!"
  end
end