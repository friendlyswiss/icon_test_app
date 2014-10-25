class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.friendly.find(params[:id])
  	
    #Change these to change the text that corresponds to each icon form, 1-20
    @trial_form = [
  		"",
  		"Trash Can",
  		"Cloud",
  		"Flag",
  		"Lock",
  		"Radio",
  		"Shopping Cart",
  		"Trophy",
  		"Tools",
  		"Cog",
  		"Person",
  		"Microphone",
  		"Camera",
  		"Magnifying Glass",
  		"Phone",
  		"Thumbs Up",
      "Scissors",
  		"Star",
  		"Key",
  		"Tags",
  		"Speech Bubble"
  	]
  end

	def update
		@trial = Trial.friendly.find(params[:id])
		
    #Only update trial task time if no time already exists. Prevents do-overs
    if @trial.task_time == nil
      @trial.update_attributes(trial_params)
		end

    #If Trial 1-23, send the user to the next trial in the sequence
    if @trial.sequence_order < 24
			next_trial = Trial.find(@trial.id + 1)
			redirect_to trial_path(next_trial)
		
    #If Trial 24, update the trial's session with the following
    else
      session = @trial.session
      outliers_present = false

      #Calculate success rate for all 24 trials and "normalized" success rate for only Trials 5-24
      success_rate = session.trials.where(:task_success => true).count.to_f / 24
      success_rate_normalized = session.trials.where("task_success = ? AND sequence_order >= ?", true, 5).count.to_f / 20

      #Mark session as having outliers if any trials 5-24 took longer than 20 seconds
      if session.trials.where("task_time >= ? AND sequence_order >= ?", 20000, 5).count > 0
        outliers_present = true
      end

      #Mark session as "complete" if all of its trials have a task time recorded
      if session.trials.where("task_time is not null")
        session_complete = true
      end
      
      session.update_attributes(
        success_rate: success_rate,
        success_rate_normalized: success_rate_normalized,
        outliers_present: outliers_present,
        session_complete: session_complete)

      #After updating session info, send user to Questionnaire
			redirect_to questionnaire_path(session)
		
    end
	end

	private

	def trial_params
    params.require(:trial).permit(:task_success, :task_time)
  end
end