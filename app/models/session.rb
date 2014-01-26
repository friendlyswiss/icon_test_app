class Session < ActiveRecord::Base
 	has_many :trials, dependent: :destroy
	include FriendlyId
  	friendly_id :random_id
end
