class Constants
  BASE_URL = 'https://graph.facebook.com/v2.6'

  PAYLOAD_MENU_MAIN_CURRENT_SURVEY = 'PAYLOAD_MENU_MAIN_CURRENT_SURVEY'
  PAYLOAD_MENU_MAIN_SEND_SUGGESTION = 'PAYLOAD_MENU_MAIN_SEND_SUGGESTION'
  PAYLOAD_MENU_HELP = 'PAYLOAD_MENU_HELP'

  PAYLOAD_MENU_YES = 'PAYLOAD_MENU_YES'
  PAYLOAD_MENU_NO = 'PAYLOAD_MENU_NO'


  PAYLOAD_MAIN_WELCOME = 'PAYLOAD_MAIN_WELCOME'
  PAYLOAD_RETAKE_SURVEY = 'PAYLOAD_RETAKE_SURVEY'

  COMMAND_CURRENT_SURVEY = 'SURVEY'
  COMMAND_SUGGESTION = 'SUGGESTION'
  COMMAND_RETAKE_SURVEY = 'RETAKE SURVEY'

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

  HELP_MESSAGE = "This bot allow you play the Hangman game." +
      "\r\n\r\nYou can start by click on New Game menu option." +
      "\r\nEach times, you can only answer by only 1 character." +
      "\r\n\r\nHint:\r\n- You can type \"menu\" to show the main menu.\r\n- You can type \"start\" to start the game immediately.\r\n- You can type \"reset user\" to reset your score and all games."
end