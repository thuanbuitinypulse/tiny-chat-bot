include Facebook::Messenger

Bot.on :postback do |postback|
  sender_id = postback.sender['id']

  case postback.payload
    when Constants::PAYLOAD_MAIN_WELCOME
      UserServices.initialize_user(sender_id)
      BotServices.message(Message.new(sender_id: sender_id, content: Constants::HELP_MESSAGE))
      puts "Registered user with id: #{sender_id}"

    when Constants::PAYLOAD_MENU_MAIN_CURRENT_SURVEY
      SurveyServices.check_current_survey(sender_id)

    when Constants::PAYLOAD_MENU_MAIN_SEND_SUGGESTION
      SurveyServices.get_suggestion(sender_id)

    when Constants::PAYLOAD_MENU_HELP
      BotServices.message(Message.new(sender_id: sender_id, content: Constants::HELP_MESSAGE))
  end
end