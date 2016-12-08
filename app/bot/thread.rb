require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Thread.set(
  {
    setting_type: 'greeting',
    greeting: {
        text: 'Hi {{user_first_name}}, welcome to TINYpulse bot! Thanks for your registration. Please click on the "Get Start" to start.'
    },
  },
  access_token: ENV['ACCESS_TOKEN']
)

Facebook::Messenger::Thread.set(
  {
    setting_type: 'call_to_actions',
    thread_state: 'new_thread',
    call_to_actions: [
        {
            payload: Constants::PAYLOAD_MAIN_WELCOME
        }
    ]
  },
  access_token: ENV['ACCESS_TOKEN']
)

Facebook::Messenger::Thread.set(
  {
    setting_type: 'call_to_actions',
    thread_state: 'existing_thread',
    call_to_actions: Constants::MENU_BUTTONS,
  },
  access_token: ENV['ACCESS_TOKEN']
)
