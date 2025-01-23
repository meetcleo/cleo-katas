class TrafficLight
  def initialize(direction:, state:, timer:)
    @direction = direction
    @state = state
    @timer = timer
  end

  attr_reader :direction
  attr_accessor :state, :timer
end
