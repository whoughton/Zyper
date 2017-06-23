class VideoController < ApplicationController
	require 'rest-client'
	require 'pp'

	def listing
		@query_params = {
			app_key: Rails.application.secrets.zype_api_key,
			page: 1,
			per_page: 12
		}

		response = RestClient.get 'https://api.zype.com/videos', { params: @query_params }
		parsed = JSON.parse response.body

		@videos = parsed["response"]
		@pagination = parsed["pagination"].with_indifferent_access

		# byebug
	end

	def watch

	end
end
