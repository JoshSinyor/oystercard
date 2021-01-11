class Oystercard

  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "It exceeds the #{DEFAULT_LIMIT} limit." if amount + balance > DEFAULT_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
