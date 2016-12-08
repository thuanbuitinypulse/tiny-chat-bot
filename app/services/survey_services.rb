class SurveyServices
  def self.answer_for_question(sender_id, type, content)
    session = Session.find_by(user_id: sender_id)

    Response.find_or_create_by(session_id: session.id, response_type: type, content: content)

    self.get_additional(sender_id)
  end

  def self.get_additional(sender_id)
    session = Session.find_by(user_id: sender_id)

    if session.survey_pending?
      BotServices.message(Message.new(sender_id: sender_id, content: 'Can you give us more idea?'))
      session.submit_additional!
    end
  end

  def self.respond(sender_id, message)
    session = Session.find_by(user_id: sender_id)

    if session.survey_pending?
      self.answer_for_question(sender_id, Response::ANSWER_QUESTION, message)
    elsif session.additional_pending?
      # TODO send survey here

      BotServices.message(Message.new(sender_id: sender_id, content: 'We received your feedback, thanks for taking time!'))
      session.idling!
    elsif session.suggestion_pending?
      # TODO: send sugesstion
    end
  end
end