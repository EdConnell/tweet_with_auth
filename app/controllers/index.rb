get '/' do
  erb :index
end

post '/tweet' do
	user = Twitter::Client.new(oauth_token: session[:token], oauth_token_secret: session[:token_secret])
  user.update(params[:tweet])
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
	session.clear
	redirect '/'
end

get '/oauth/callback' do
	# need this in line below? oauth_token: params["oauth_token"]
	access = session[:request_token].get_access_token(oauth_verifier: params["oauth_verifier"])
	tweeter = Tweeter.find_or_initialize_by_handle(access.params[:screen_name])
	tweeter.update_attributes(token: access.token, token_secret: access.secret)
	session[:tweeter] = tweeter.handle
	redirect '/'
end
