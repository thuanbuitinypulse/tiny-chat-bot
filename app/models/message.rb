class Message
  include ActiveModel::Model
  attr_accessor :sender_id, :content, :subtitle, :url, :buttons
end