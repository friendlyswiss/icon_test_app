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
		form = ((1..20).to_a.sample 4).concat((1..20).to_a.shuffle)
		
		style_color = Array[
				Array["solid", "white_bg"],
				Array["hollow", "white_bg"],
				Array["solid", "black_bg"],
				Array["hollow", "black_bg"]
				].shuffle.concat(
					Array.new(5, Array["solid", "white_bg"]).concat(
					Array.new(5, Array["hollow", "white_bg"])).concat(
					Array.new(5, Array["solid", "black_bg"])).concat(
					Array.new(5, Array["hollow", "black_bg"])).shuffle
				)

		while i < 24 do
			@session.trials.create(:sequence_order => i + 1, :target_form => form[i], :style => style_color[i][0], :color => style_color[i][1])
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
		@session.update_attributes(session_params)
		redirect_to @session
	end

	private

	def session_params
    params.require(:session).permit(:test_browser, :test_os, :test_device, :primary_os, :primary_mobile, :age, :years_exp, :success_rate)
  end
end
