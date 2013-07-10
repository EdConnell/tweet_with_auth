def request_token
  host_and_port = request.host
  host_and_port << ":9393" if request.host == "localhost"
  #callback_url = "http://127.0.0.1:9393/oauth/callback"
  consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'],ENV['TWITTER_SECRET'], :site => "https://api.twitter.com")
  session[:request_token] = consumer.get_request_token(:oauth_callback => "http://#{host_and_port}/oauth/callback")
end

def fetch_tweets!(handle)
  puts Twitter.methods
  Twitter.search("from:#{handle}", :count => 10, :result_type => "recent").results.map do |status|
    status.text
  end
end
