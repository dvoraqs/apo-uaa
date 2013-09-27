class PushController < ApplicationController

  def google
    flash[:notice] = "You found me!"
    redirect_to root_url
  end
end