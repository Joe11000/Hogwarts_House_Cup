require_relative '../spec_helper'
require_relative '../../lib/wizarding_school'

require 'factory_girl'

RSpec.describe "Hogwarts House Cup Competition" do
  it '' do
    school = wizarding_school_populated
    professors = school.professors

    expected_house_cup_standings = []

    # simulate teachers awarding points to houses
    school.houses.each_with_index do |house, i|
      professors.first.award i, house
      expected_house_cup_standings << [house.name, house.points]
    end
    expected_house_cup_standings.reverse!

    expect(school.house_cup_winner).to eq expected_house_cup_standings.first

  end
end
