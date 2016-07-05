class FivehundredpxApi
  require 'rubygems'
  require 'oauth'
  include HTTParty

  @@access_token = {}
  @base_uri = 'https://api.500px.com'

  def self.generate_access_token(username, password)
    consumer = OAuth::Consumer.new(ENV["fivehundredpx_consumer_key"], ENV["fivehundredpx_secret_key"], {
    :site               => @base_uri,
    :request_token_path => "/v1/oauth/request_token",
    :access_token_path  => "/v1/oauth/access_token",
    :authorize_path     => "/v1/oauth/authorize"})

    request_token = consumer.get_request_token()

    begin
      @@access_token = consumer.get_access_token(request_token, {}, { :x_auth_mode => 'client_auth', :x_auth_username => username, :x_auth_password => password })
    rescue
      return
    end

    @@access_token
  end

  def self.set_access_token(value)
    @@access_token = value
  end

  def self.get_access_token()
    @@access_token
  end

  def self.get_photos_with_votes
    response = @@access_token.get("#{@base_uri}/v1/photos?feature=popular&sort=times_viewed&rpp=100&image_size=3&include_states=voted").body
    response
  end

  def self.get_photos(consumer_key)
    @options = { query: {consumer_key: consumer_key} }
    HTTParty.get("#{@base_uri}/v1/photos?feature=popular&sort=times_viewed&rpp=100&image_size=3", @options).body
  end

  def self.check_api_status
    HTTParty.get(@base_uri).code
  end

  def self.vote(photo_id)
    response = @@access_token.post("#{@base_uri}/v1/photos/#{photo_id}/vote?vote=1")
    hashed_response = response.to_hash

    if hashed_response['status'][0] == '200 OK'
      return true
    else
      return false
    end
  end

end