require_relative '../spec_helper'
require_relative '../../lib/wizarding_school'

require 'pry'
require 'factory_girl'

RSpec.describe "Hogwarts House Cup Competition" do
  it '' do
    school = build(:wizarding_school_populated)
    professors = school.professors

    school.houses.each_with_index do |house, i|
      professors.first.award i, house
    end

    expext(school.house_cup_winner).to eq [school.houses.length - 1, school.houses.last]
  end
end
