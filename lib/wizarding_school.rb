require_relative './house'
require_relative './professor'
require_relative './wizard'


class WizardingSchool
  attr_reader :houses, :head_master, :professors

  def initialize args=({ houses: [], head_master: nil, professors: [] })
    @houses = args[:houses]
    @head_master = args[:head_master]
    @professors = args[:professors]
  end

  def sort wizards
    SortingHat.sort({ wizards: wizards, houses: houses })
  end

  def house_cup_winner
    house_cup_standings.first
  end

  def house_cup_standings

  end

  private
    module SortingHat
      def sort args=({ wizards: [], houses: [] })
        args.wizards.each do |wizard|
          houses[rand(0...houses.length)].wizards << wizard
        end
      end
    end
end
