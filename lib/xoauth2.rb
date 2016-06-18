class Xoauth2
  require 'rubygems'
  require 'oauth'

  @@access_token = {}

  def self.generate_access_token(username, password)
    p "get_access_token: Initializing Consumer"
    consumer = OAuth::Consumer.new(ENV["fivehundredpx_consumer_key"], ENV["fivehundredpx_secret_key"], {
    :site               => 'https://api.500px.com',
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
end