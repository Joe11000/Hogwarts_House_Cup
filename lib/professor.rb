require_relative './wizard'
require 'pry'

# pretend there are multiple uses for this duck type
module PointsAwarderRole
  attr_reader :points_awarded

  def initialize what
    @points_awarded = {}
  end

  def award points, points_receiver_role
    points_receiver_role.receive points
    @points_awarded
  end
end


class Professor < Wizard
  def initialize args=({name: 'dude'})
    super args

    class << self
      include PointsAwarderRole
    end
  end
end
