def current_user
	Tweeter.find_by_handle(session[:tweeter]) if session[:tweeter]
end

def signed_in?
	current_user
end

