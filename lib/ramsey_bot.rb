require 'telegram/bot'
require 'google_places'
require_relative '../config.rb'


class Bot
  @google = GooglePlaces::Client.new(GOOGLE_PLACES_API_KEY)

  def initialize
    Telegram::Bot::Client.run(TELEGRAM_TOKEN_ID) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I'm Ramsey's chatbot!")
        end
      end
    end
  end
end