# pretend there are multiple uses for this duck type
module PointsAwarderRole
  attr_reader :points_awarded

  def initialize
    @points_awarded = {}
  end

  def award points, points_receiver_role
    points_receiver_role.receive points
    @points_awarded
  end
end

class Professor
  include PointsAwarderRole
end
