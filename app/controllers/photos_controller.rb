class PhotosController < ApplicationController
  require 'fivehundredpx_api'

  def index
    if signed_in? == true
      @signed_in = true
      response = FivehundredpxApi.get_photos_with_votes
    else
      response = FivehundredpxApi.get_photos(ENV["fivehundredpx_consumer_key"])
    end
    get_photos = JSON.parse(response)
    @photos = get_photos["photos"]
  end

  def show
    response = FivehundredpxApi.vote(params[:id])
    if response == true
      flash[:notice] = 'Successfully voted on photo.'
    else
      flash[:alert] = 'An error occured when trying to vote, please try again later.'
    end

    redirect_to photos_path
  end

end
