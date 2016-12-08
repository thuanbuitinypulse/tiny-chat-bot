include Facebook::Messenger

Bot.on :optin do |optin|
  optin.sender    # => { 'id' => '1008372609250235' }
  optin.recipient # => { 'id' => '2015573629214912' }
  optin.sent_at   # => 2016-04-22 21:30:36 +0200
  optin.ref       # => 'CONTACT_SKYNET'

  Bot.deliver(
      recipient: optin.sender,
      message: {
          text: 'Welcome back'
      },
      access_token: ENV['ACCESS_TOKEN']
  )
end