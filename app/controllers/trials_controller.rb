class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.friendly.find(params[:id])
  	@trial_form = [
  		"",
  		"Trash",
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
			session = Session.find(@trial.session_id)
			redirect_to questionnaire_path(session)
		end
	end

	private

	def trial_params
    params.require(:trial).permit(:task_success, :task_time)
  end
end