class Journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @fare = 0
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def finalize(exit_station)
    @exit_station = exit_station
    fare
  end

  def fare
    @entry_station.nil? || @exit_station.nil? ? @fare = PENALTY_FARE : @fare = MINIMUM_FARE
  end
end
