require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :journey, :journey_history

  DEFAULT_MAXIMUM_CARD_VALUE = 90
  DEFAULT_MINIMUM_CARD_VALUE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "The maximum card value is £#{DEFAULT_MAXIMUM_CARD_VALUE}" if amount + balance > DEFAULT_MAXIMUM_CARD_VALUE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds." if balance < DEFAULT_MINIMUM_CARD_VALUE
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MINIMUM_CARD_VALUE)
    @journey.instance_variable_set(:@exit_station, exit_station)
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
