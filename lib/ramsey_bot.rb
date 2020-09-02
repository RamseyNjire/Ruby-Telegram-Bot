require 'telegram/bot'
require 'google_places'
require_relative '../config.rb'


class Bot
  @google = GooglePlaces::Client.new(GOOGLE_PLACES_API_KEY)

  def initialize
    Telegram::Bot::Client.run(TELEGRAM_TOKEN_ID) do |bot|
      bot.listen do |message|
        # if message.location
        #   location = message.location
        #   restaurants = @google.spots(location.latitude, location.longitude, :types => ['restaurant', 'food'], :radius => 1000)
        #   for restaurant in restaurants
        #     bot.api.send_location(chat_id: message.chat.id, latitude: restaurant.lat, longitude: restaurant.lng) 
        #   end
        # end
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I'm Ramsey's chatbot! He likes to build stuff. Right now, this chatbot he built can show you nearby restaurants. Just send the command '/food' and see!")
        when '/food'
          kb = [Telegram::Bot::Types::KeyboardButton.new(text: "What's your location?", request_location: true)]
          markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
          bot.api.send_message(chat_id: message.chat.id, text: 'Please allow Telegram to access your location.', reply_markup: markup)
          location = message.location
          restaurants = @google.spots(location.latitude, location.longitude, :types => ['restaurant', 'food'], :radius => 500)
          for restaurant in restaurants
            bot.api.send_location(chat_id: message.chat.id, latitude: restaurant.lat, longitude: restaurant.lng) 
          end
        end
      end
    end
  end
end