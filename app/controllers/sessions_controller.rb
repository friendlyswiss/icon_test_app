class SessionsController < ApplicationController

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(params[:session])
		
		#Detect browser, OS, device and assign test_browser, test_os, test_device
		@session.save

		#Create 24 trials
		@trials = Array.new
		i = 0
		solid = 6
		hollow = 6
		white_bg = 6
		black_bg = 6
		while i < 24 do
			@trials.push (
				@session.trials.create(:sequence_order => i)
			)
			i += 1
		end

		#Redirect to first trial
		redirect_to @trials[0]
	end

	def show
		@session = Session.find(params[:id])
	end
end
