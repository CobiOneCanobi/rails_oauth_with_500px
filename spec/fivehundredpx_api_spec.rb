require 'rails_helper'
require_relative '../lib/fivehundredpx_api'

describe FivehundredpxApi do

  let(:bad_key) {FivehundredpxApi.new('ffefwfhiuhufhrier')}
  let(:good_key) {FivehundredpxApi.new(ENV["fivehundredpx_consumer_key"])}

  it 'fails to return popular photos due to invalid consumer key for api' do
    expect(bad_key.popular_photos.to_hash['status']).to eq(403)
  end

  it 'returns popular photos due to valid consumer key for api' do
    expect(good_key.popular_photos.to_hash['photos']).to_not be_empty
  end

  it 'returns 100 photos' do
    expect(good_key.popular_photos.to_hash['photos'].size).to eq(100)
  end

end