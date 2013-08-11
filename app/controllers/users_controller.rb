class UsersController < ApplicationController
  # force_ssl
  # possibly re-enable when Openshift supports custom SSL certificates

  def index
    @page = @header = 'Users List'

    if current_user == nil || current_user.access_level < 3
      flash[:alert] = 'Not authorized to view that page'
      redirect_to '/'
    end

    @users = User.all
  end

  def new
    @page = @header = 'New User'
    @user = User.new
  end

  def show
    # display a specific user
    @user = User.find(params[:id])
    @page = @header = @user.name
    @nav = 'User'

    if @user.access_level >= 3
      @needs_verification = User.where('status IS NULL || status = "Unverified"').all
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => 'You are now registered. Welcome ' + @user.name + '!'
    else
      flash[:alert] = 'The user could not be created'
      redirect_to new_user_path
    end
  end

  def update
    @user = User.find(params[:verify_id])
    if @user.update_attributes({:status => params[:user][:status], :user_id => params[:id]})
      flash[:notice] = @user.name + ' was successfully verified as a/an ' + @user.status + ' account'
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'There was a problem changing the verification on the user'
      redirect_to user_path(current_user)
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "Successfully deleted user " + user.name
      redirect_to users_path
    else
      flash[:alert] = "There was a problem deleting user " + user.name
      redirect_to users_path
    end
  end
end