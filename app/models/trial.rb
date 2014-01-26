class Trial < ActiveRecord::Base
	belongs_to :session
	include FriendlyId
  	friendly_id :random_id
end
