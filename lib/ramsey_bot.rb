require 'telegram/bot'
require_relative '../config.rb'
require_relative '../lib/motivational_quotes.rb'


class Bot

  def initialize
    Telegram::Bot::Client.run(TELEGRAM_TOKEN_ID) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I'm Ramsey's chatbot! He likes to build stuff. Right now, this chatbot is experimental.")
        end
      end
    end
  end
end