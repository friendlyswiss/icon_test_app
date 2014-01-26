class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.friendly.find(params[:id])
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