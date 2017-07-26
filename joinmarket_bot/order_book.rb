require 'httparty'

module JoinmarketBot
  class OrderBook
    def initialize
      # TODO: can initialize order book instance w/ nick id
      # to enable comparison of one's orders to the rest of the book.
    end

    def inspect
      # fetch the contents of the order book via
      # https://joinmarket.me/objson/
      # display the contents of the order book
    end
  end
end
