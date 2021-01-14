class Journey

  attr_reader :entry_station
  attr_accessor :exit_station

  DEFAULT_ENTRY_STATION = nil
  DEFAULT_EXIT_STATION = nil

  def initialize(entry_station = DEFAULT_ENTRY_STATION)
    @entry_station = entry_station
    @exit_station = DEFAULT_EXIT_STATION
  end

  def touch_out(exit_station)
    @exit_station = exit_station
  end

  def finish

  end

  def fare

  end

  def complete?

  end

end
