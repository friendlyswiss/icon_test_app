class SessionsController < ApplicationController
	respond_to :html, :json

	def index
		@cleaned_sessions = Session.all #plus some cleaning

		respond_to do |format|
			format.json { render :json => @cleaned_sessions }
		end
	end

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
		
		@all_time = avg_time('either', 'either')
		@solid_time = avg_time('solid', 'either')
		@hollow_time = avg_time('hollow','either')
		@black_time = avg_time('either', 'white_bg')
		@white_time = avg_time('either', 'black_bg')
		@solid_black_time = avg_time('solid', 'white_bg')
		@hollow_black_time = avg_time('hollow', 'white_bg')
		@solid_white_time = avg_time('solid', 'black_bg')
		@hollow_white_time = avg_time('hollow', 'black_bg')

		@all_acc = accuracy('either', 'either')
		@solid_acc = accuracy('solid', 'either')
		@hollow_acc = accuracy('hollow','either')
		@black_acc = accuracy('either', 'white_bg')
		@white_acc = accuracy('either', 'black_bg')
		@solid_black_acc = accuracy('solid', 'white_bg')
		@hollow_black_acc = accuracy('hollow', 'white_bg')
		@solid_white_acc = accuracy('solid', 'black_bg')
		@hollow_white_acc = accuracy('hollow', 'black_bg')
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

	def session_params
    params.require(:session).permit(:test_browser, :test_os, :primary_os, :primary_mobile, :age, :years_exp, :success_rate, :success_rate_normalized)
  end

	def avg_time (style, color)
		if style == 'either' && color == 'either'
			(@session.trials.average('task_time').to_f / 1000).round(3)
		elsif style == 'either'
			(@session.trials.where(color: color).average('task_time').to_f / 1000).round(3)
		elsif color == 'either'
			(@session.trials.where(style: style).average('task_time').to_f / 1000).round(3)
		else
			(@session.trials.where("style = ? AND color = ?", style, color).average('task_time').to_f / 1000).round(3)
		end
	end

	def accuracy (style, color)
		if style == 'either' && color == 'either'
			(@session.trials.where(task_success: true).count.to_f / 0.24).round(1)
		elsif style == 'either'
			(@session.trials.where("color = ? AND task_success = ?", color, true).count.to_f / 0.12).round(1)
		elsif color == 'either'
			(@session.trials.where("style = ? AND task_success = ?", style, true).count.to_f / 0.12).round(1)
		else
			(@session.trials.where("style = ? AND color = ? AND task_success = ?", style, color, true).count.to_f / 0.06).round(1)
		end
	end
end
