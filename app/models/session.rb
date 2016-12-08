class Session < ActiveRecord::Base
  include Workflow
  workflow_column :state
  workflow do
    state :idle do
      event :submit_survey, :transitions_to => :survey_pending
      event :send_suggestion, :transitions_to => :suggestion_pending
    end
    state :survey_pending do
      event :idling, :transitions_to => :idle
      event :submit_additional, :transitions_to => :additional_pending
      event :send_suggestion, :transitions_to => :suggestion_pending
      event :submit_survey, :transitions_to => :survey_pending
    end
    state :suggestion_pending do
      event :submit_survey, :transitions_to => :survey_pending
      event :idling, :transitions_to => :idle
      event :send_suggestion, :transitions_to => :suggestion_pending
    end

    state :additional_pending do
      event :idling, :transitions_to => :idle
      event :send_suggestion, :transitions_to => :suggestion_pending
      event :submit_survey, :transitions_to => :survey_pending
    end
  end

  belongs_to :user
end
