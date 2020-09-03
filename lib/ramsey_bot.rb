# frozen_string_literal: true

require 'telegram/bot'
require_relative '../config.rb'
require_relative '../lib/motivational_quotes.rb'

class Bot
  def initialize
    Telegram::Bot::Client.run(TELEGRAM_TOKEN_ID) do |bot|
      bot.listen do |message|
        case message.text
        when /start/i
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, I'm Ramsey's chatbot! He likes to build stuff. Right now, this chatbot is experimental. You can find out basic information about Ramsey using the 'info' command and get a random motivational quote using the 'quote' command. This is just for fun. Maybe he'll add more functionality to me later, maybe he won't; life's short and there are a lot of things to learn and build!")
        when /info/i
          bot.api.send_message(chat_id: message.chat.id, text: "Ramsey is a software engineer. Technically, he's still learning and doing it for fun. He hasn't started doing it professionally just yet, but he's keen to start soon. He's 26 years old. His birthday is on the 8th of September, 1993. He loves chicken biriyani, Go Karting, thinking, and laughing, in no specific order. He also loves to solve problems and build stuff, and hopes that he can apply his problem solving skills to real-word problems and make life a little easier for as many people as possible. If you want to know more, chat him up on his personal chat, @RamseyNjire.")
          bot.api.send_message(chat_id: message.chat.id, text: "Want a quote? Type 'quote' and send, and see what happens!")
        when /quote/i
          quote = Quotes.new.random_quote
          bot.api.send_message(chat_id: message.chat.id, text: (quote['text']).to_s, date: message.date)
          bot.api.send_message(chat_id: message.chat.id, text: "Want another quote(A.K.A a motivational joke because they make you believe you can be as rich as Jeff Bezos just by waking up at 5 a.m and taking cold showers)? Type 'quote' and send, and see what happens!")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Sorry, I don't understand '#{message.text}'. I only understand 'start', 'info', and 'quote'. Try typing 'quote', for example, and see what happens.")
        end
      end
    end
  end
end
