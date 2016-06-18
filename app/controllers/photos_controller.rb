class PhotosController < ApplicationController
  require 'fivehundredpx_api'
  require 'xoauth2'

  def index
    if signed_in? == true
      @signed_in = true
      response = Xoauth2.get_photos_with_votes
      get_photos = JSON.parse(response)
    else
      response = FivehundredpxApi.new
      get_photos = response.popular_photos
    end

    @photos = get_photos["photos"]

  end

  def show
    response = Xoauth2.vote(params[:id])
    redirect_to photos_path
  end

end
