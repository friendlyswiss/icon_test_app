class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.find(params[:id])
  end

	def update
		@trial = Trial.find(params[:id])
		@trial.update_attributes(trial_params)
		if @trial.sequence_order < 24
			redirect_to trial_path(@trial.id + 1)
		else
			redirect_to edit_session_path(@trial.session_id)
		end
	end

	private

	def trial_params
    params.require(:trial).permit(:task_success, :age)
  end
end