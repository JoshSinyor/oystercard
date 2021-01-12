class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :journeys

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "It exceeds the #{DEFAULT_LIMIT} limit." if amount + balance > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < DEFAULT_MINIMUM
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MINIMUM)
    @entry_station = nil
    @exit_station = exit_station
    @journeys << {station: exit_station}
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
