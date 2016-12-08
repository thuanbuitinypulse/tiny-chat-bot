class Response < ActiveRecord::Base
  belongs_to :session

  ANSWER_QUESTION = 'answer_question'
  ADDITIONAL = 'additional'
  SUGGESTION = 'suggestion'
end
