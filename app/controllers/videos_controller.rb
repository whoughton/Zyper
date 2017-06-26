class VideosController < ApplicationController
	require 'ZypeGateway'

	def home

	end

	def index
		page_num = params[:page].to_i || 1
		@videos, @pagination = ZypeGateway.getListings(page_num)
	end

	def show
		@video, @player_path = ZypeGateway.getVideo(params['id'], session[:access_token])

		if @video[:subscription_required] && session[:access_token].blank?
			session[:attempted_video] = @video[:_id]
			flash[:notice] = "A subscription is required to view that video."

			redirect_to session_index_path and return
		end

		session.delete :attempted_video
	end
end
