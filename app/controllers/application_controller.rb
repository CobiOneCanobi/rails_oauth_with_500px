class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'fivehundredpx_api'

  def signed_in?
    if FivehundredpxApi.get_access_token != {}
      true
    end
  end
end
