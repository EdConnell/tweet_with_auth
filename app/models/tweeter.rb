class Tweeter < ActiveRecord::Base
	validate :handle, uniqueness: true
  has_many :tweets

	def twitter_client
		@twitter_client ||=  Twitter::Client.new(oauth_token: token, oauth_token_secret: token_secret)
	end

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

end
