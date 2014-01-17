class Session < ActiveRecord::Base
	has_many :trials, dependent: :destroy
end
