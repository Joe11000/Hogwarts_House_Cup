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
  attr_reader :founder, :students, :name

  include PointsReceiverRole

  def initialize args=({ name: '', students: [], founder: nil })
    @students = args[:students]
    @founder = args[:founder]
    @name = args[:name]

    super()
  end
end

