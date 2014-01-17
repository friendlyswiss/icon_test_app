class TrialsController < ApplicationController

  def create
  end

  def show
  	@trial = Trial.find(params[:id])
  end

  def destroy
  end
end