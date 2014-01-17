class SessionsController < ApplicationController

	def new
		@session = Session.new
	end

	def create
		@session = Session.new(params[:session])
		@session.save
		redirect_to @session
	end

	def show
		@session = Session.find(params[:id])
	end
end
