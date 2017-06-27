module ZypeGateway
  require 'rest-client'
  require 'cgi'

  def self.getListings(page_num = 1, page_size = 16)
    response = RestClient.get 'https://api.zype.com/videos', { params: {
      app_key: Rails.application.secrets.zype_api_key,
      page: page_num,
      per_page: page_size
    } }

    begin
      parsed = JSON.parse response.body
      return parsed['response'], parsed['pagination'].with_indifferent_access

    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.debug "Received an error from the Zype API"
      return false, "Zype API Error: #{e.inspect}."

    rescue Exception => e
      Rails.logger.debug "getVideo Exception: #{e.inspect}"
      return false, false
    end
  end

  def self.authenticate(user, pass)
    query_params = {
      client_id: Rails.application.secrets.zype_client_id,
      client_secret: Rails.application.secrets.zype_client_secret,
      username: user,
      password: pass,
      grant_type: 'password'
    }

    begin
      response = RestClient.post 'https://login.zype.com/oauth/token/', query_params
      parsed = JSON.parse response.body
      return parsed.with_indifferent_access

    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.debug "Received an error from the Zype API"
      return false, "The credentials could not be validated as entered, please try again."

    rescue Exception => e
      Rails.logger.debug "Received an error parsing the API response"
      return false, "There was an error parsing the response from the Authentication API."
    end
  end

  def self.getVideo(id, access_token = nil)
    id = CGI.escape id
    query_params = {
      app_key: Rails.application.secrets.zype_api_key
    }
    query_params[:access_token] = access_token if !access_token.nil?

    response = RestClient.get "https://api.zype.com/videos/#{id}", { params: query_params }

    begin
      parsed = JSON.parse response.body
      video = parsed['response'].with_indifferent_access

      player_path = "https://player.zype.com/embed/#{video[:_id]}.js?#{query_params.to_query}"
      return video, player_path

    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.debug "Received an error from the Zype API"
      return false, "Zype API Error: #{e.inspect}."

    rescue Exception => e
      Rails.logger.debug "getVideo Exception: #{e.inspect}"
      return false, false
    end
  end
end
