class Tweeter < ActiveRecord::Base
	validate :handle, uniqueness: true

	def twitter_client
		@twitter_client ||=  Twitter::Client.new(oauth_token: token, oauth_token_secret: token_secret)
	end
end
