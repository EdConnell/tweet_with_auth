class CreateTweeters < ActiveRecord::Migration
  def change
  	create_table :tweeters do |t|
  		t.string :handle
  		t.string :token
  		t.string :token_secret
  	end
  end
end
