# pretend there are multiple uses for this duck type
module PointsReceiverRole
  attr_reader :points

  def initialize
    @points = 0
  end

  def receive points
    @points += points
  end
end

class House
  attr_reader :founder, :wizards, :name

  include PointsReceiverRole

  def initialize args=({ name: '', wizards: [], founder: nil })
    @wizards = args[:wizards]
    @founder = args[:founder]
    @name = args[:name]

    super()
  end
end

