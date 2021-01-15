require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey, :journey_history

  DEFAULT_MAXIMUM_CARD_VALUE = 90
  DEFAULT_MINIMUM_CARD_VALUE = 1

  def initialize
    @balance = 0
    @journey = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "The maximum card value is £#{DEFAULT_MAXIMUM_CARD_VALUE}" if amount + @balance > DEFAULT_MAXIMUM_CARD_VALUE
    @balance += amount
  end

  def touch_in(entry_station)
    touch_out(nil) if !@journey.nil?
    fail "Insufficient funds." if @balance < DEFAULT_MINIMUM_CARD_VALUE
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @journey = Journey.new if @journey.nil?
    @journey.finalize(exit_station)
    complete_journey
  end

  def in_journey?
    @journey.nil?
  end

  private

  def complete_journey
    deduct
    @journey_history.push(@journey)
    @journey = nil
  end

  def deduct
    @balance -= @journey.fare
  end
end
