class SessionsController < ApplicationController
	respond_to :html, :json

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

	end

	def edit
		@session = Session.friendly.find(params[:id])
	end

	def update
		@session = Session.friendly.find(params[:id])
		@session.update_attributes(session_params)
		redirect_to results_path(@session)
	end

	
	def index
		
		sid = params[:sid]
		my_session = Session.find(sid)
		cleaned_sessions = Session.all #plus some cleaning
		categories = []
		group2_data = nil

		#Pull from completed session or filter on all people
		if params[:group1_is] == 'me'
			group1_data = my_session.my_results(params[:speed_accuracy_select],params[:style_select],params[:color_select])
		elsif params[:group1_is] == 'all-people'
			group1_data = [4,3,2,1]
				#cleaned_sessions.my_results(params[:speed_accuracy_select],params[:style_select],params[:color_select])					
		end
		
		#Group 2 only gets filtered if it's showing
		if params[:no_groups] == 2
			#group2_data = cleaned_sessions.my_results(params[:speed_accuracy],params[:style],params[:color])
		end
		


		series1 = {name: 'Group 1', data: group1_data}
		series2 = {name: 'Group 2', data: [1,2,3,4]} #group2_data}]

		if params[:no_groups] == '1'
			series = [series1]
		else
			series = [series1, series2]
		end
		
		

		@chart_options = {
			chart: {
					type: 'column',
					renderTo: 'chart-container',
					style: {
						fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif'
					}
				},
				title: {
					text: 'title'
				},
				xAxis: {
					categories: ["Solid Black","Hollow Black","Solid White","Hollow White"],
					title: {
						text: "Style/Color Combinations"
					}
				},
				yAxis: {
					type: "linear",
					title: {
						text: "Time"
					}
				},

				series: series,

				colors: [
				   '#00bcdf',
				   '#ed145b'
				],
				credits: {
					enabled: false
				}
			}
		respond_to do |format|
			format.json { render :json => @chart_options }
		end
	end

	

	private

	def session_params
    params.require(:session).permit(:test_browser, :test_os, :primary_os, :primary_mobile, :age, :years_exp, :success_rate, :success_rate_normalized)
  end
end
