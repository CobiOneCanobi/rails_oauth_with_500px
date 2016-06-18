class Xoauth2
  require 'rubygems'
  require 'oauth'

  @@access_token = {}
  @base_uri = 'https://api.500px.com'

  def self.generate_access_token(username, password)
    p "get_access_token: Initializing Consumer"
    consumer = OAuth::Consumer.new(ENV["fivehundredpx_consumer_key"], ENV["fivehundredpx_secret_key"], {
    :site               => @base_uri,
    :request_token_path => "/v1/oauth/request_token",
    :access_token_path  => "/v1/oauth/access_token",
    :authorize_path     => "/v1/oauth/authorize"})

    request_token = consumer.get_request_token()
    p "Request URL: #{request_token.authorize_url}"
    @@access_token = consumer.get_access_token(request_token, {}, { :x_auth_mode => 'client_auth', :x_auth_username => username, :x_auth_password => password })
  end

  def self.set_access_token(value)
    @@access_token = value
  end

  def self.get_access_token()
    @@access_token
  end

  def self.get_photos_with_votes
    response = @@access_token.get("https://api.500px.com/v1/photos?feature=popular&sort=times_viewed&rpp=100&image_size=3&include_states=voted").body
    response
  end

  def self.vote(photo_id)
    response = @@access_token.post("https://api.500px.com/v1/photos/#{photo_id}/vote?vote=1")
    hashed_response = response.to_hash

    if hashed_response['status'][0] == '200 OK'
      return true
    else
      return false
    end
  end
end


 # access_token = Xoauth2.instance_eval {@@access_token}