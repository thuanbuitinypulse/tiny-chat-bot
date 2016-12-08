class SurveysController < ApplicationController
  def send_survey
    sender_id = params[:sender_id]
    question_content = params[:question][:content]
    question_type = params[:question][:type]

    SurveyServices.show_survey(sender_id, question_content, question_type)

    render json: { status: 200, message: 'Success' }
  end
end
