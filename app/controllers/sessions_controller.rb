class SessionsController < ApplicationController
  require 'xoauth2'

  def new
    if signed_in? == true
      redirect_to photos_path
    end
  end

  def create
    Xoauth2.generate_access_token(params[:username], params[:password] )
    access_token = Xoauth2.get_access_token

    if access_token
      redirect_to photos_path
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    Xoauth2.set_access_token({})
    redirect_to photos_path
  end

end
