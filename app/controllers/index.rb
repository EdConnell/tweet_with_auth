get '/' do
  erb :index
end

post '/tweet' do
	current_user.twitter_client.update(params[:tweet])
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
	redirect '/'
end
