require 'spec_helper'

RSpec.describe JoinmarketBot::OrderBook do
  describe "#market_depth" do
    context 'relative offer order type' do
      pending

      it 'calculates the weighted average offer price of relative offers only' do
      end
    end

    context 'absolute offer order type' do
      pending
    end

    context 'no offer type argument' do
      pending

      it 'calculates the weight average offer price using all order types' do
      end
    end
  end
end
