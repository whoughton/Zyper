class SessionController < ApplicationController
	require 'ZypeGateway'

	def index
		redirect_to videos_path if !session[:access_token].blank?
	end

	def create
		success, message = ZypeGateway.authenticate(params[:username], params[:password])

		if !message.nil?
			flash[:notice] = message
			redirect_to session_index_path and return
		end

		if success[:access_token].empty?
			flash[:notice] = "The credentials could not be validated as entered, please try again."
			redirect_to session_index_path and return
		end

		session[:access_token] = success[:access_token]

		if !session[:attempted_video].blank?
			redirect_to video_path session[:attempted_video] and return
		end

		redirect_to videos_path
	end

	def destroy
		reset_session
		redirect_to videos_path and return
	end
end
