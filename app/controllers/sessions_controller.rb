class SessionsController < ApplicationController
	respond_to :html, :json


	def new
		@session = Session.new
	end


	#CREATE A SESSION AND ITS 24 TRIALS
	def create
		@session = Session.new(session_params)

		#Generate a random ID for the new session
		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
		random_id = (0...6).map { o[rand(o.length)] }.join
		@session.random_id = random_id
		
		@session.session_complete = false
		@session.save

		#CREATE 24 TRIALS

		#Create an array of 24 integers representing the target icon form for each trial in this session.
		#The first four integers are selected randomly from 1-20 (without repeating any).
		#Then the next 20 integers are selected randomly from 1-20 (without repeating any).
		target_forms = ((1..20).to_a.sample 4).concat((1..20).to_a.shuffle)
		
		#Create an array of 24 style-color combinations for the 24 trials.
		#Each of the first four trials is assigned a unique, non-repeating style-color combination.
		#Each of the style-color combinations appears five more times over the next 20 trials, in a random order.
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
		
		#Construct 24 new trials with information from the above arrays		
		i = 0
		while i < 24 do
			
			#Generate a random ID for each new trial
			o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
			random_id = (0...6).map { o[rand(o.length)] }.join

			@session.trials.create(:random_id => random_id, :sequence_order => i + 1, :target_form => target_forms[i], :style => style_color[i][0], :color => style_color[i][1])
			i += 1
		end

		#After all 24 trials are constructed, redirect the user to the first trial
		redirect_to trial_path(@session.trials.find_by(sequence_order: 1))
	end

	#CALCULATE DATA FOR RESULTS SCREEN
	def show
		
		@session = Session.friendly.find(params[:id])
		@incorrect_notice = "hidden"

		#Get the participant's fastest and slowest five trials
		@fastest = @session.trials.order("task_time ASC").limit(5)
		@slowest = @session.trials.order("task_time DESC").limit(5)
		
		#CALCULATE THE PERCENTILE SCORE FOR THE SESSION

		#Calculate the average task time from the session.
		@avg_task_time = (@session.trials.average("task_time") / 1000)


		#------REMOVED FOR PERFORMANCE IMPROVEMENTS-------

		#Create an array of average task times for all sessions
		
		#Include avg task time for all sessions by all users where all trials are completed, the success rate for trials 5-24 is >75%, and no trials longer than 20 seconds exist.
		# @avg_task_times = []
		# cleaned_sessions = Session.where("session_complete = ? AND success_rate_normalized >= ? AND outliers_present = ?", true, 0.75, false)
		# cleaned_sessions.each do |session|
		# 	@avg_task_times << (session.trials.where(sequence_order: 5..24).average('task_time').to_f / 1000)	
		# end

		#Step through each average task time to find percentile score.
		
		# @avg_task_times.sort.reverse.each_with_index do |task_time, index|
		# 	if @avg_task_time > task_time
		# 		@speed_percentile = ((index.to_f / @avg_task_times.length.to_f)*100).round(0)
		# 		break
		# 	end
		# end
		# if @speed_percentile == nil
		# 	@speed_percentile = 100
		# end
	
	
		#------ADDED FOR PERFORMANCE IMPROVEMENTS-------


		#Create an array of average task times for all sessions
		
		#Static data from official study dataset: no warmups, no outliers (99.7%)
		#Times in 20 quantiles: 100th percentile (fastest) time, 95th percentile time, 90th percentile time, etc.
		@avg_task_times = [13803, 5908, 4771, 4192, 3802, 3511, 3276, 3074, 2903, 2740, 2597, 2465, 2333, 2211, 2097, 1983, 1872, 1762, 1643, 1501, 927]
		
		#Step through each average task time to find percentile score.

		@avg_task_times.each_with_index do |task_time, index|
				if @avg_task_time * 1000 > task_time
					@speed_percentile = index * 5
					break
				end
			end
			if @speed_percentile == nil
				@speed_percentile = 100
			end

	end

	def edit
		@session = Session.friendly.find(params[:id])
	end


	#SUBMIT QUESTIONNAIRE RESPONSES
	def update
		@session = Session.friendly.find(params[:id])
		@session.update_attributes(session_params)
		redirect_to results_path(@session)
	end


	#GET DATA FOR CHART ON RESULTS PAGE
	def index
		sid = params[:sid]
		my_session = Session.find(sid)
		group2_data = nil
		group1_name = 'Me'
		group1_query = ["sessions.session_complete = ? AND sessions.success_rate_normalized >= ? AND sessions.outliers_present = ?", true, 0.75, false]
		group2_query = ["sessions.session_complete = ? AND sessions.success_rate_normalized >= ? AND sessions.outliers_present = ?", true, 0.75, false]

		if params[:group1_age_multiselect] != 'all'
			group1_query[0] << " AND sessions.age = ?"
			group1_query << params[:group1_age_multiselect]
		end
		if params[:group1_primary_os_multiselect] != 'any'
			group1_query[0] << " AND sessions.primary_os = ?"
			group1_query << params[:group1_primary_os_multiselect]
		end
		if params[:group1_primary_mobile_multiselect] != 'any'
			group1_query[0] << " AND sessions.primary_mobile = ?"
			group1_query << params[:group1_primary_mobile_multiselect]
		end

		if params[:group2_age_multiselect] != 'all'
			group2_query[0] << " AND sessions.age = ?"
			group2_query << params[:group2_age_multiselect]
		end
		if params[:group2_primary_os_multiselect] != 'any'
			group2_query[0] << " AND sessions.primary_os = ?"
			group2_query << params[:group2_primary_os_multiselect]
		end
		if params[:group2_primary_mobile_multiselect] != 'any'
			group2_query[0] << " AND sessions.primary_mobile = ?"
			group2_query << params[:group2_primary_mobile_multiselect]
		end

		#Pull from completed session or filter on all people
		if params[:group1_is] == 'me'
			group1_name = 'Me'
			group1_data = my_session.my_results(params[:speed_accuracy_select],params[:style_select],params[:color_select])

		elsif params[:group1_is] == 'all_people'
			valid_trials_for_selected_group1 = Trial.joins(:session).where(group1_query)

			group1_name = 'Group 1'
			group1_data = valid_trials_for_selected_group1.results(params[:speed_accuracy_select], params[:style_select], params[:color_select])					
		end
		
		#Group 2 only gets filtered if it's showing
		if params[:no_groups] == '2'
			valid_trials_for_selected_group2 = Trial.joins(:session).where(group2_query)
			
			group2_data = valid_trials_for_selected_group2.results(params[:speed_accuracy_select], params[:style_select], params[:color_select])
			group2_data.pop; group2_data.pop
		end
		
		title = group1_data.pop
		labels = group1_data.pop
		
		series1 = {name: group1_name, data: group1_data}

		if params[:no_groups] == '1'
			series = [series1]
		else
			series2 = {name: 'Group 2', data: group2_data}
			series = [series1, series2]
		end
		
		if params[:speed_accuracy_select] == 'speed'
			yaxis = {	type: "linear",	title: { text: "Time (seconds)"	}, labels: { format: '{value} sec'}	}
		elsif params[:speed_accuracy_select] == 'accuracy'
			yaxis = {	type: "linear",	title: { text: "Percent Correct"	}, labels: { format: '{value}%'}, max: 100	}
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
					text: title
				},
				xAxis: {
					categories: labels,
					title: {
						text: "Icon Style/Color Combinations",
						offset:60,
						align:'middle'
					},
					labels: { useHTML: true }
				},
				yAxis: yaxis,

				series: series,

				colors: [
				   '#04c4f4',
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
    params.require(:session).permit(:test_browser, :test_os, :primary_os, :primary_mobile, :age, :years_exp, :success_rate, :success_rate_normalized, :outliers_present, :session_complete)
  end
end
