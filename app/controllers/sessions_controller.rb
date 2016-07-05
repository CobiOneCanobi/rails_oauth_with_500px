class SessionsController < ApplicationController
  require 'fivehundredpx_api'

  def new
    if signed_in? == true
      redirect_to photos_path
    end
  end

  def create
    FivehundredpxApi.generate_access_token(params[:username], params[:password] )
    access_token = FivehundredpxApi.get_access_token
    unless access_token == {}
      redirect_to photos_path
    else
      flash.now[:alert] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    FivehundredpxApi.set_access_token({})
    redirect_to photos_path
  end

end
