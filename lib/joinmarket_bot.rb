path = File.dirname(__FILE__)
$:.unshift(path) unless $:.include?(path)

require 'joinmarket_bot/order_book'
require 'joinmarket_bot/offer'

module JoinmarketBot
end
