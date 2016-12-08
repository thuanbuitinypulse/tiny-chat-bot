require 'httparty'

class FacebookServices
  include HTTParty

  def self.user_info(id)
    response = HTTParty.get("#{Constants::BASE_URL}/#{id}?fields=first_name,last_name&access_token=#{ENV['facebook_bot_access_token']}")
    if response.message == 'OK'
      return JSON.parse(response.body)
    end

    false
  end
end