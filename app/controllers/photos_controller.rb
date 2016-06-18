class PhotosController < ApplicationController
  require 'fivehundredpx_api'
  require 'xoauth'

  def index
    response = FivehundredpxApi.new
    get_photos = response.popular_photos
    @photos = get_photos["photos"]

    if signed_in?
      @signed_in = true
    end
  end

end
