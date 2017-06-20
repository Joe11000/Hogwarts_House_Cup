require_relative './house'
require_relative './professor'
require_relative './wizard'

require 'active_support/core_ext/enumerable.rb'

class WizardingSchool
  attr_reader :houses, :head_master, :professors

  def initialize args=({ houses: [], head_master: nil, professors: [] })
    @houses = args[:houses]
    @head_master = args[:head_master]
    @professors = args[:professors]
  end

  def sort wizards
    SortingHat.sort({ students: wizards, houses: houses })
    self
  end

  def house_cup_winner
    house_cup_standings.first
  end

  def house_cup_standings
    houses.sort { |house1, house2| house2.points <=> house1.points }
          .map {|house| [house.name, house.points] }
  end

  private
    module SortingHat
      def self.sort args=({ students: [], houses: [] })
        args[:students].each do |student|
          args[:houses][rand(0...args[:houses].length)].students << student
        end
      end
    end
end
