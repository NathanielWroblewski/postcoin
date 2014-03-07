# 1 Bitcoin equals X
SATOSHIS = 100_000_000
MILLIBIT = 1_000

FEE = 10_000
MINIMUM_DEPOSIT = 20_000

class Numeric
  def to_satoshis
    (self * SATOSHIS).round.to_i
  end


  def to_millibit_satoshis
    (self * SATOSHIS / MILLIBIT).round.to_i
  end
end


class String
  def is_number?
    true if Float(self) rescue false
  end

  def to_satoshis
    to_f.to_satoshis
  end

  def to_millibit_satoshis
    to_f.to_millibit_satoshis
  end
end
