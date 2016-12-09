class SurveyServices
  def self.answer_for_question(sender_id, type, content)
    session = Session.find_by(user_id: sender_id)
    Response.create(session_id: session.id, response_type: type, content: content)

    self.get_additional(sender_id)
  end

  def self.get_additional(sender_id)
    session = Session.find_by(user_id: sender_id)

    if session.survey_pending?
      BotServices.message(Message.new(sender_id: sender_id, content: 'Do you want to share why?'))
      session.submit_additional!
    end
  end

  def self.respond(sender_id, message)
    session = Session.find_by(user_id: sender_id)

    if session.survey_pending?
      if message.upcase.include?('later'.upcase)
        BotServices.message(Message.new(sender_id: sender_id, content: "Okie np #{Emojivert.name_to_unified('FACE WITH STUCK-OUT TONGUE AND WINKING EYE')}"))
      else
        self.answer_for_question(sender_id, Response::ANSWER_QUESTION, message)
      end

    elsif session.additional_pending?
      if message.upcase.include?('yes'.upcase)
        BotServices.message(Message.new(sender_id: sender_id, content: "Cool, I'm listening #{Emojivert.name_to_unified('EAR')}"))
      else
        self.submit_response(sender_id, Response.where(session_id: session.id, response_type: Response::ANSWER_QUESTION).last.content, message)

        BotServices.generic_message(
            Message.new(
                sender_id: sender_id,
                content: "Thanks for sharing. Your TINYpulse has been submitted. #{Emojivert.name_to_unified('THUMBS UP SIGN')}",
                subtitle: "Your streak is 8. #{Emojivert.name_to_unified('SMILING FACE WITH HEART-SHAPED EYES')}"))
        session.idling!
      end

    elsif session.suggestion_pending?
      if message.upcase.include?('sure'.upcase)

        self.submit_suggestion(sender_id, Response.where(session_id: session.id, response_type: Response::SUGGESTION).last.content)
        BotServices.message(Message.new(sender_id: sender_id, content: "Thanks for your suggestion. Keep doing that! #{Emojivert.name_to_unified('PERSON WITH FOLDED HANDS')}"))
        session.idling!
      else
        Response.create(session_id: session.id, response_type: Response::SUGGESTION, content: message)
        BotServices.message(Message.new(sender_id: sender_id, content: "Should I submit your suggestion now ?"))
      end
    end
  end

  def self.get_suggestion(sender_id)
    session = Session.find_by(user_id: sender_id)

    BotServices.message(Message.new(sender_id: sender_id, content: "Cool, I can help you on that, just tell me what is your thought? #{Emojivert.name_to_unified('WHITE SMILING FACE')}"))
    session.send_suggestion!
  end

  def self.check_current_survey(sender_id)
    current_survey = self.get_current_survey(sender_id)

    question = current_survey['question']
    if question['submitted']
      BotServices.generic_message(
          Message.new(
              sender_id: sender_id,
              content: question['content'],
              subtitle: "Your responded: #{question['response']}.#{question['additional'] ? " #{question['additional']}" : ''}",
              buttons: [{
                            type: 'web_url',
                            title: 'Show More',
                            url: "#{Constants::TINYPULSE_URL}/livepulse/inbox?response_token=#{question['response_token']}&current_week=yes&popover=true&filter=Response"
                        }]))
    else
      SurveyServices.show_survey(sender_id, question['content'], question['type'])
    end
  end

  def self.show_survey(sender_id, question_content, question_type)

    session = Session.find_or_create_by(user_id: sender_id)

    if question_type == 'Question::BooleanQuestion'
      BotServices.show_confirmation(
          Message.new(
              sender_id: sender_id,
              content: question_content,
              buttons: Constants::YES_NO_BUTTONS
          ))
    else
      BotServices.message(Message.new(sender_id: sender_id, content: question_content))
    end

    session.submit_survey!
  end

  def self.get_cheers(sender_id)
    BotServices.generic_message(
        Message.new(
            sender_id: sender_id,
            content: 'You can send Cheers in your employee portal.',
            subtitle: 'Click on button below to send cheers.',
            buttons: [{
                          type: 'web_url',
                          title: 'Send Cheers',
                          url: "#{Constants::TINYPULSE_URL}/livepulse/cheers/send"
                      }]))
  end

  def self.show_next_survey(sender_id)
    survey = self.get_next_survey(sender_id)

    if survey
      session = Session.find_by(user_id: sender_id)
      survey = survey['survey']

      current_survey = self.get_current_survey(sender_id)
      question = current_survey['question']

      BotServices.message(
          Message.new(
              sender_id: sender_id,
              content: "Your next survey is - #{survey['content']}\r\n\r\nYour still haven't answer this week survey - #{question['content']}"
          )
      )

      session.submit_survey!
    end
  end

  private
  def self.get_current_survey(sender_id)
    response = HTTParty.get("#{Constants::TINYPULSE_URL}/facebook/current_survey?sender_id=#{sender_id}")
    if response.message == 'OK'
      return JSON.parse(response.body)
    end
  end

  def self.get_next_survey(sender_id)
    response = HTTParty.get("#{Constants::TINYPULSE_URL}/facebook/next_survey?sender_id=#{sender_id}")
    if response.message == 'OK'
      return JSON.parse(response.body)
    end
  end

  def self.submit_response(sender_id, content, additional)
    HTTParty.post(
        "#{Constants::TINYPULSE_URL}/facebook/submit_response",
        body: {
            sender_id: sender_id,
            response: content,
            additional: additional
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
    )
  end

  def self.submit_suggestion(sender_id, content)
    HTTParty.post(
        "#{Constants::TINYPULSE_URL}/facebook/submit_suggestion",
        body: {
            sender_id: sender_id,
            suggestion: content
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
    )
  end
end