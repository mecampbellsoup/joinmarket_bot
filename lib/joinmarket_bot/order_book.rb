require 'httparty'
require 'active_support/core_ext/hash'

module JoinmarketBot
  class OrderBook
    BASE_URI = "https://joinmarket.me/objson".freeze
    ServiceUnavailable = Class.new(StandardError)

    def initialize
      # TODO: can initialize order book instance w/ nick id
      # to enable comparison of one's orders to the rest of the book.
      #
      @response = HTTParty.get(BASE_URI)
    end

    def to_json
      case response.code
      when 200
        offers.map(&:to_json)
      when 500 ... 600
        raise(ServiceUnavailable)
      else
        raise("Unepxected response from #{BASE_URI}: #{response.code}, #{response.body}.")
      end
    end

    def market_depth(offer_type = ['reloffer', 'absoffer'])
      # Summary statistics including:
      # * number of offers for the given type (all types if no type arg)
      # * the weighted average offer rate
      # * the mean, median, mode offer rates
      {
        offer_count: offers_by(offer_type).size,
        weighted_average_rate: weighted_average_rate(offer_type)
      }
    end

    private

    def weighted_average_rate(type)
      offers = offers_by(type)
      offer_rates = offers.map(&:txfee)
      max_offer_sizes = offers.map(&:maxsize)

      sum_of_max_offer_sizes = max_offer_sizes.inject(0) do |sum, (test, weight)|
        binding.pry
        sum += grades[test].nil? ? 0 : weight
      end # => 0.75

      weighted_score = grades.inject(0) do |w, (test, score)|
        w += (score.to_f * WEIGHTS[test])
      end # => 0.6625

      final_score = weighted_score / SUM_OF_WEIGHTS # => 0.8833333333333333
    end

    def offers_by(type)
      offers.select { |o| Array(type).include?(o.ordertype) }
    end

    def offers
      _offers = JSON.parse(response.body)
      _offers.map { |o| Offer.new(o) }
    end

    attr_reader :response
  end
end
