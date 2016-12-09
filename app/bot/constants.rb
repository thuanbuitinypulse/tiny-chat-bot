class Constants
  BASE_URL = 'https://graph.facebook.com/v2.6'
  TINYPULSE_URL = 'http://app.lvh.me:3000'

  PAYLOAD_MENU_MAIN_CURRENT_SURVEY = 'PAYLOAD_MENU_MAIN_CURRENT_SURVEY'
  PAYLOAD_MENU_MAIN_SEND_SUGGESTION = 'PAYLOAD_MENU_MAIN_SEND_SUGGESTION'
  PAYLOAD_MENU_HELP = 'PAYLOAD_MENU_HELP'

  PAYLOAD_MENU_YES = 'PAYLOAD_MENU_YES'
  PAYLOAD_MENU_NO = 'PAYLOAD_MENU_NO'

  PAYLOAD_MAIN_WELCOME = 'PAYLOAD_MAIN_WELCOME'
  PAYLOAD_RETAKE_SURVEY = 'PAYLOAD_RETAKE_SURVEY'

  COMMAND_HELP = 'HELP'
  COMMAND_CURRENT_SURVEY = 'CURRENT SURVEY'
  COMMAND_SUGGESTION = 'SUGGESTION'
  COMMAND_CHEERS = 'CHEERS'
  COMMAND_RETAKE_SURVEY = 'RETAKE SURVEY'
  COMMAND_HI = 'HI'
  COMMAND_NEXT_SURVEY = 'NEXT SURVEY'

  MENU_BUTTONS = [
      {
          type: 'postback',
          title: 'Current Survey',
          payload: Constants::PAYLOAD_MENU_MAIN_CURRENT_SURVEY
      },
      {
          type: 'postback',
          title: 'Send Suggestion',
          payload: Constants::PAYLOAD_MENU_MAIN_SEND_SUGGESTION
      },
      {
          type: 'postback',
          title: 'Help',
          payload: Constants::PAYLOAD_MENU_HELP
      }
  ]

  YES_NO_BUTTONS = [
      {
          content_type: 'text',
          title: 'Yes',
          payload: Constants::PAYLOAD_MENU_YES
      },
      {
          content_type: 'text',
          title: 'No',
          payload: Constants::PAYLOAD_MENU_NO
      }
  ]

  HELP_MESSAGE = "Hi! I'm TINYbuddy #{Emojivert.name_to_unified('WHITE SMILING FACE')}" +
      "\r\n\r\nYou can ask me to check the status of your current survey, send cheers and suggestions." +
      "\r\nOr more simple, you can use the Menu at the bottom left if you don't know how to ask me."
end