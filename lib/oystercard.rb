class Oystercard

  attr_reader :balance
  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "It exceeds the #{DEFAULT_LIMIT} limit." if amount + balance > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in
    fail "Insufficient funds" if balance < DEFAULT_MINIMUM
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    @balance -= DEFAULT_MINIMUM
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
