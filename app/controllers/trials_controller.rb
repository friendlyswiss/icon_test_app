class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.friendly.find(params[:id])
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
		@trial.update_attributes(trial_params)
		
    if @trial.sequence_order < 24
			next_trial = Trial.find(@trial.id + 1)
			redirect_to trial_path(next_trial)
		
    else
			session = @trial.session
      session_success_rate = session.trials.where(:task_success => true).count.to_f / 24
      session_success_rate_normalized = session.trials.where("task_success = ? AND sequence_order >= ?", true, 5).count.to_f / 20

      #Mark session as having outliers if any trials 5-24 took longer than 20 seconds
      if session.trials.where("task_time >= ? AND sequence_order >= ?", 20000, 5).count > 0
        session_outliers_present = true
      else session_outliers_present = false
      end

      if session.trials.where("task_time is not null")
        session_complete = true
      else session_complete = false
      end
      
      session.update_attributes(
        success_rate: session_success_rate,
        success_rate_normalized: session_success_rate_normalized,
        outliers_present: session_outliers_present,
        session_complete: session_complete)

			redirect_to questionnaire_path(session)
		end
	end

	private

	def trial_params
    params.require(:trial).permit(:task_success, :task_time)
  end
end