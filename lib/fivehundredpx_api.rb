class FivehundredpxApi
  include HTTParty
  base_uri 'https://api.500px.com'

  def initialize(consumer_key)
    @options = { query: {consumer_key: consumer_key} }
  end

  def popular_photos
    self.class.get("/v1/photos?feature=popular&sort=times_viewed&rpp=100&image_size=3&include_states=voted", @options)
  end

end