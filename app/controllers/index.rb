get '/' do
	erb :index
end

post '/tweet' do
	jid = current_user.tweet(params[:tweet])
	content_type :json
	{job: jid}.to_json
end

post '/job/:jid' do
	content_type :json
	{finished: job_is_complete(params[:jid])}.to_json
end

get '/sign_in' do
	redirect request_token.authorize_url
end

get '/sign_out' do
	session.clear
	redirect '/'
end

get '/oauth/callback' do
	access = session[:request_token].get_access_token(oauth_verifier: params["oauth_verifier"])
	session[:request_token] = nil
	tweeter = Tweeter.find_or_initialize_by_handle(access.params[:screen_name])
	tweeter.update_attributes(token: access.token, token_secret: access.secret)
	# tweeter.twitter_client.user[:profile_image_url].sub('normal', 'bigger')
	session[:tweeter] = tweeter.handle
	session.delete(:request_token)
	redirect '/'
end

get '/tweets/fetch' do
	#@tweets = fetch_tweets!(current_user.handle)
	@tweets = current_user.twitter_client.search("from:#{current_user.handle}", :count => 10, :result_type => "recent").results.map do |status|
		status.text
	end
	erb :fetch
end
