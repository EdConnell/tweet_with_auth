def request_token
  callback_url = "http://sleepy-island-2135.herokuapp.com/oauth/callback"
  consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'],ENV['TWITTER_SECRET'], :site => "https://api.twitter.com")
  session[:request_token] = consumer.get_request_token(:oauth_callback => callback_url)
end
