class SessionsController < ApplicationController
  require 'xoauth2'

  def new
    if signed_in?
      redirect_to photos_path
    end
  end

  def create
    # response = Xoauth.new
    # access_token = response.generate_access_token(params[:username], params[:password])
    Xoauth2.generate_access_token(params[:username], params[:password] )
    access_token = Xoauth2.get_access_token
    if access_token
      # access_token1 =Base64.decode64(access_token)
      # ApiKey.create(access_token: access_token1).save
      # ApiKey.new.merge(access_token)
      redirect_to photos_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
    # user = User.find_by_email(params[:email])
    # if user && user.authenticate(params[:password])
    #   session[:user] = user.id
    #   sign_in user
    #   redirect_to user
    # else
    #   flash.now[:error] = 'Invalid email/password combination'
    #   render 'new'
    # end
  end

  def destroy
    Xoauth2.set_access_token('{}')
    redirect_to photos_path
  end

end
