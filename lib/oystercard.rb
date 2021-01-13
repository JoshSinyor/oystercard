require_relative 'journey_2'

class Oystercard

  attr_reader :balance, :entry_station, :journeys, :journey_2

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1

  def initialize
    @balance = 0
    @journey_2 = nil
    @journeys = []
  end

  def top_up(amount)
    fail "It exceeds the #{DEFAULT_LIMIT} limit." if amount + balance > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds" if balance < DEFAULT_MINIMUM
    @entry_station = entry_station
    @journeys << {entry_station: entry_station, exit_station: nil}

    @journey_2 = Journey_2.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MINIMUM)
    @entry_station = nil
    @exit_station = exit_station

    @journey_2.instance_variable_set(:@exit_station, exit_station)
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
