class PhotosController < ApplicationController
  require 'fivehundredpx_api'

  def index
    response = FivehundredpxApi.new(ENV["fivehundredpx_consumer_key"])

    get_photos = response.popular_photos
    @photos = get_photos["photos"]
  end

end
