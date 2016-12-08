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
      when Constants::COMMAND_CURRENT_SURVEY

      when Constants::COMMAND_SUGGESTION

      when Constants::COMMAND_RETAKE_SURVEY
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
      else
        SurveyServices.respond(sender_id, message.text)
    end
  end
end