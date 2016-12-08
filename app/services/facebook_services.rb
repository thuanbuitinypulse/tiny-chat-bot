require 'httparty'

class FacebookServices
  include HTTParty

  def self.user_info(id)
    response = HTTParty.get("#{Constants::BASE_URL}/#{id}?fields=first_name,last_name,profile_pic&access_token=#{ENV['ACCESS_TOKEN']}")
    if response.message == 'OK'
      return JSON.parse(response.body)
    end

    false
  end

  def self.sync_sender_id(token, sender_id)
    HTTParty.post(
        "#{Constants::TINYPULSE_URL}/facebook/mapping",
        body: {
            token: token,
            sender_id: sender_id
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
    )
  end
end
