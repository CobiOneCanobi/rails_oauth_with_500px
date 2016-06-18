class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'xoauth2'

  def signed_in?
    if Xoauth2.get_access_token != {}
      true
    end
  end
end
