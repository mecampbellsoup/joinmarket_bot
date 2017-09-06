=begin
{
  "counterparty" => "J59FLVE8U12LsvVG",
  "ordertype" => "absoffer",
  "oid" => 0,
  "minsize" => 5000000,
  "txfee" => 0,
  "maxsize" => 3170482700,
  "cjfee" => 50000
}
=end

module JoinmarketBot
  OFFER_ATTRIBUTES = %i(
    counterparty
    ordertype
    oid
    minsize
    txfee
    maxsize
    cjfee
  )

  class Offer
    attr_reader :attributes, *OFFER_ATTRIBUTES

    def initialize(attributes)
      @attributes = attributes.symbolize_keys.slice(*OFFER_ATTRIBUTES)
      OFFER_ATTRIBUTES.each do |attr|
        instance_variable_set(:"@#{attr}", @attributes[attr])
      end
    end

    def to_json(*)
      attributes
    end
  end

  private_constant :Offer
end
