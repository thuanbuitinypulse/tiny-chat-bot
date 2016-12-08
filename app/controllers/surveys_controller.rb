class SurveysController < ApplicationController
  def send_survey
    sender_id = params[:sender_id]
    question_content = params[:question][:content]
    question_type = params[:question][:type]

    session = Session.find_or_create_by(user_id: sender_id)

    if question_type == 'boolean'
      BotServices.show_confirmation(
          Message.new(
              sender_id: sender_id,
              content: question_content,
              buttons: Constants::YES_NO_BUTTONS
              ))
    else
      BotServices.message(Message.new(sender_id: sender_id, content: question_content))
    end

    if session.idle?
      session.submit_survey!
    end

    render json: { status: 200, message: 'Success' }
  end
end
