class SessionsController < ApplicationController

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(session_params)

		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
		rando = (0...6).map { o[rand(o.length)] }.join
		@session.random_id = rando

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
			o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
			rando = (0...6).map { o[rand(o.length)] }.join
			@session.trials.create(:random_id => rando, :sequence_order => i + 1, :target_form => form[i], :style => style_color[i][0], :color => style_color[i][1])
			i += 1
		end

		#Redirect to first trial
		redirect_to trial_path(@session.trials.find_by(sequence_order: 1))
	end

	def show
		@session = Session.friendly.find(params[:id])
		@fastest = @session.trials.order("task_time ASC").limit(5)
		@slowest = @session.trials.order("task_time DESC").limit(5)
		@total_sessions = Session.count
	end

	def edit
		@session = Session.friendly.find(params[:id])
	end

	def update
		@session = Session.friendly.find(params[:id])
		@session.update_attributes(session_params)
		redirect_to results_path(@session)
	end

	private

	def completed?
		
	end

	def session_params
    params.require(:session).permit(:test_browser, :test_os, :primary_os, :primary_mobile, :age, :years_exp, :success_rate)
  end
end
