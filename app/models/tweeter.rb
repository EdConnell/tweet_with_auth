class Tweeter < ActiveRecord::Base
	validate :handle, uniqueness: true
end
