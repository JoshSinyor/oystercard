# Create the JourneyLog class
# Initialize with (journey_class) parameter (hint: journey_class expects an object that knows how to create Journeys. Can you think of an object that already does this?)
# Method 'start' should start a new journey with an entry_station
# Method 'current_journey' should either return the current incomplete journey, or create a new journey (if the current one is complete)
# Method 'finish' should add an exit_station to the current_journey
# Method 'journeys' should return all previous journeys

=begin

def initialize
  @journey = Journey.new
end

def start(entry_station = nil)
  @journey = Journey.new(entry_station)
end

def current_journey
  return @journey if !@journey.complete?
  start
end

def finish(exit_station)
  @journey.exit_station = exit_station
end



=end
