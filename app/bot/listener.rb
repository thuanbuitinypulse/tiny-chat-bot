include Facebook::Messenger

Bot.on :message do |message|
  sender_id = message.sender['id']
  BotServices.show_indicator(sender_id)

  if message.quick_reply.present?
    case message.quick_reply
      when Constants::PAYLOAD_MENU_YES
        SurveyServices.answer_for_question(sender_id, Response::ANSWER_QUESTION, 1)
      when Constants::PAYLOAD_MENU_NO
        SurveyServices.answer_for_question(sender_id, Response::ANSWER_QUESTION, 0)
    end
  else
    case message.text.upcase
      when Constants::COMMAND_HELP
        BotServices.message(Message.new(sender_id: sender_id, content: Constants::HELP_MESSAGE))

      when Constants::COMMAND_HI
        BotServices.message(Message.new(sender_id: sender_id, content: ["Good morning #{Emojivert.name_to_unified('PILE OF POO')}", "Hey #{Emojivert.name_to_unified('PILE OF POO')}"].sample))
      else
        if message.text.upcase.include?(Constants::COMMAND_CURRENT_SURVEY)
          SurveyServices.check_current_survey(sender_id)
        elsif message.text.upcase.include?(Constants::COMMAND_SUGGESTION)
          SurveyServices.get_suggestion(sender_id)
        elsif message.text.upcase.include?(Constants::COMMAND_RETAKE_SURVEY)
          BotServices.show_confirmation(
              Message.new(
                  sender_id: sender_id,
                  content: 'Are you sure?',
                  buttons: [
                      {
                          content_type: 'text',
                          title: 'Yes, please!',
                          payload: Constants::PAYLOAD_RETAKE_SURVEY
                      }
                  ]))
        elsif message.text.upcase.include?(Constants::COMMAND_CHEERS)
          SurveyServices.get_cheers(sender_id)
        elsif message.text.upcase.include?(Constants::COMMAND_NEXT_SURVEY)
          SurveyServices.show_next_survey(sender_id)
        else
          SurveyServices.respond(sender_id, message.text)
        end
    end

  end
end