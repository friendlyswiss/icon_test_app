class SessionsController < ApplicationController

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(params[:session])
		
		#Detect browser, OS, device and assign test_browser, test_os, test_device
		@session.save

		#Create 24 trials
		i = 0
		form = Array.new(4, rand(1..20)).concat((1..20).to_a.shuffle)
		style = Array.new(2, "solid").concat(Array.new(2, "hollow")).shuffle.concat(Array.new(10, "solid").concat(Array.new(10, "hollow")).shuffle)
		color = Array.new(2, "white_bg").concat(Array.new(2, "black_bg")).shuffle.concat(Array.new(10, "white_bg").concat(Array.new(10, "black_bg")).shuffle)

		while i < 24 do
			@session.trials.create(:sequence_order => i + 1, :target_form => form[i], :style => style[i], :color => color[i])
			i += 1
		end

		#Redirect to first trial
		redirect_to @session.trials.find_by(sequence_order: 1)
	end

	def show
		@session = Session.find(params[:id])
	end

	def edit
		@session = Session.find(params[:id])
	end

	def update
		@session = Session.find(params[:id])
		redirect_to @session
	end
end
