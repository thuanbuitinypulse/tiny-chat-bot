include Facebook::Messenger

class BotServices
  def self.show_main_menu(sender_id)
    Bot.deliver(
        {
            recipient: {
                id: sender_id
            },
            message: {
                attachment: {
                    type: 'template',
                    payload: {
                        template_type: 'button',
                        text: 'Please select to start',
                        buttons: Constants::MENU_BUTTONS
                    }
                }
            }
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end

  def self.message(msg)
    Bot.deliver(
        {
            recipient: {
                id: msg.sender_id
            },
            message: {
                text: msg.content
            }
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end

  def self.generic_message(msg)
    Bot.deliver(
        {
            recipient: {
                id: msg.sender_id
            },
            message: {
                attachment: {
                    type: "template",
                    payload: {
                        template_type: "generic",
                        elements: [
                            {
                                title: msg.content,
                                image_url: msg.url,
                                subtitle: msg.subtitle,
                                buttons: msg.buttons
                            }
                        ]
                    }
                }
            }
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end

  def self.show_indicator(sender_id)
    Bot.deliver(
        {
            recipient: {
                id: sender_id
            },
            sender_action: 'typing_on'
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end

  def self.show_confirmation(msg)
    Bot.deliver(
        {
            recipient: {
                id: msg.sender_id
            },
            message: {
                text: msg.content,
                quick_replies: msg.buttons
            }
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end

  def self.show_login(msg)
    Bot.deliver(
        {
            recipient: {
                id: msg.sender_id
            },
            message: {
                attachment: {
                  type: "template",
                  payload: {
                    template_type: "generic",
                    elements: [{
                      title: "Welcome to M-Bank",
                      image_url: "http://www.example.com/images/m-bank.png",
                      buttons: [{
                        type: "account_link",
                        url: "http://app.lvh.me:3000/signin"
                      }]
                    }]
                  }
                }
            }
        },
        access_token: ENV['ACCESS_TOKEN']
    )
  end
end