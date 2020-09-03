require 'json'
require 'net/http'

class Quotes
  attr_reader :quote_set

  def initialize
    @quote_set = make_request
  end

  def random_quote
    @quote_set = @quote_set.sample
  end

  def make_request
    uri = URI('https://type.fit/api/quotes')
    response = JSON.parse(Net::HTTP.get(uri))
  end
end