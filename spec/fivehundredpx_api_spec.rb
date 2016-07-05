require 'rails_helper'
require_relative '../lib/fivehundredpx_api'

describe FivehundredpxApi do

  it 'is online' do
    expect(FivehundredpxApi.check_api_status).to eq(200)
  end

  context 'not logged in' do
    let(:bad_key) {'ffefwfhiuhufhrier'}
    let(:good_key) {ENV["fivehundredpx_consumer_key"]}

    it 'fails to return popular photos due to invalid consumer key for api' do
      response = FivehundredpxApi.get_photos(bad_key)
      get_photos = JSON.parse(response)

      expect(get_photos['status']).to eq(403)
    end

    it 'returns popular photos due to valid consumer key for api' do
      response = FivehundredpxApi.get_photos(good_key)
      get_photos = JSON.parse(response)

      expect(get_photos['photos']).to_not be_empty
    end

    it 'returns 100 photos' do
      response = FivehundredpxApi.get_photos(good_key)
      get_photos = JSON.parse(response)

      expect(get_photos['photos'].size).to eq(100)
    end
  end

  context 'logging in' do
    let(:username) {ENV["fivehundredpx_username"]}
    let(:password) {ENV["fivehundredpx_password"]}
    let(:fake_username) {"vbkjeqhr"}
    let(:fake_password) {"ohoihgyvyu"}

    it 'succeeds in receiving access token from API due to valid username and password' do
      expect(FivehundredpxApi.generate_access_token(username, password)).to be_kind_of(OAuth::AccessToken)
    end

    it 'fails to receive access_token from API due to invalid username and password' do
      expect(FivehundredpxApi.generate_access_token(fake_username, fake_password)).to eq(nil)
    end
  end

  context 'with valid access token' do

    before(:each) do
      FivehundredpxApi.generate_access_token(ENV["fivehundredpx_username"], ENV["fivehundredpx_password"])
    end

    it 'returns popular photos with each photo containing a voted key' do
      response = FivehundredpxApi.get_photos_with_votes
      get_photos = JSON.parse(response)

      expect(get_photos['photos'][0]).to include('voted')
    end

    it 'returns 100 photos' do
      response = FivehundredpxApi.get_photos_with_votes
      get_photos = JSON.parse(response)
      expect(get_photos['photos'].size).to eq(100)
    end
  end

end