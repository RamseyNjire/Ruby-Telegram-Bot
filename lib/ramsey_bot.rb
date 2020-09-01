require 'telegram/bot'
require_relative '../config.rb'


class Bot
  TOKEN = TOKEN_ID
  def initialize
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I'm Ramsey's chatbot!")
        end
      end
    end
  end
end