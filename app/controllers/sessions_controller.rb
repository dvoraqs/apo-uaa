class SessionsController < ApplicationController
  force_ssl

  def new
    @page = @header = 'Log In'
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/', :notice => 'Welcome back, ' + user.name + '!'
    else
      flash[:alert] = 'That was an invalid username or password'
      render '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', :notice => "You've logged out. See you later!"
  end
end