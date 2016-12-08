Rails.application.routes.draw do
  post 'surveys/send_survey'

  mount Facebook::Messenger::Server, at: 'bot'
end
