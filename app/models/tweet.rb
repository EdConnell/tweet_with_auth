class Tweet < ActiveRecord::Base
  belongs_to :tweeter
  validates :status, :presence => true

end
