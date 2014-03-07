require 'active_support/concern'

module AmountParsable
  extend ActiveSupport::Concern

  ### Supported Currency Symbols:
  ### Order matters, higher means more priority
  PATTERNS = [
    {
      name: :mBTC_SUFFIX,
      regex: /(\d*.?\d*)\s?mBTC/i,
      satoshify: Proc.new {|num| num.to_millibit_satoshis }
    },
    {
      name: :mBTC_PREFIX,
      regex: /mBTC\s?(\d*.?\d*)/i,
      satoshify: Proc.new {|num| num.to_millibit_satoshis }
    },
    {
      name: :BTC_SUFFIX,
      regex: /(\d*.?\d*)\s?BTC/i,
      satoshify: Proc.new {|num| num.to_satoshis }
    },
    {
      name: :bitcoin_SUFFIX,
      regex: /(\d*.?\d*)\s?bitcoin/i,
      satoshify: Proc.new {|num| num.to_satoshis }
    },
    {
      name: :BTC_SIGN,
      regex: /฿\s?(\d*.?\d*)/i,
      satoshify: Proc.new {|num| num.to_satoshis }
    },
    {
      name: :BTC_PREFIX,
      regex: /BTC\s?(\d*.?\d*)/i,
      satoshify: Proc.new {|num| num.to_satoshis }
    },
    {
      name: :USD,
      regex: /(\d*.?\d*)\s?USD/i,
      satoshify: Proc.new {|num| (num.to_f / Bitstamp.latest).to_satoshis }
    },
    {
      name: :dollar,
      regex: /(\d*.?\d*)\s?dollar/i,
      satoshify: Proc.new {|num| (num.to_f / Bitstamp.latest).to_satoshis }
    },
    {
      name: :USD_SIGN,
      regex: /\$\s?(\d*.?\d*)/i,
      satoshify: Proc.new {|num| (num.to_f / Bitstamp.latest).to_satoshis }
    }
  ]

  def parse(subject)
    PATTERNS.each do |pattern|
      matches = subject.scan(pattern[:regex]).flatten
      matches.each do |match|
        if match.is_number? && satoshis = pattern[:satoshify].call(match)
          return satoshis
        end
      end
    end
    0
  end
end
