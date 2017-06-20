require_relative '../spec_helper'
require_relative '../../lib/wizarding_school'
require 'factory_girl'


RSpec.describe WizardingSchool do
  context 'factory' do
    it ':wizarding_school is valid and blank' do
      expect(build(:wizarding_school).houses).to eq []
      expect(build(:wizarding_school).head_master).to eq nil
      expect(build(:wizarding_school).professors).to eq []
    end

    it ':wizarding_school_populated is valid and populated' do
      houses = build(:wizarding_school_populated).houses
      expect(houses).to all( be_a(House) )
      houses.each do |house|
        house.students.each do |wizard|
          attributes_for(:wizard_populated).each do |wizard_attribute|
            expect(wizard.send wizard_attribute[0] ).to_not be_nil
          end
        end
      end

      expect(build(:wizarding_school_populated).houses).to all( be_a(House) )
      expect(build(:wizarding_school_populated).head_master).to an_instance_of(Professor)
      expect(build(:wizarding_school_populated).professors).to all( be_a(Wizard) )
    end
  end

  context 'instance' do

    let(:wizarding_school_populated) { build(:wizarding_school_populated) }

    context '#houses' do
      it 'list houses' do
        expect(wizarding_school_populated.houses).to all(be_a House)
      end
    end

    context '#head_master' do
      it 'is an instance of Professor' do
        expect(wizarding_school_populated.head_master).to be_a Professor
      end
    end

    context '#professors' do
      it 'list professors' do
        expect(wizarding_school_populated.professors).to all(be_a Professor)
      end
    end

    context '#sort' do
      it "sorts students into houses based on house's specs" do
        new_students = 2.times.collect { build(:wizard_populated) }
        found_students_tracker = Array.new(new_students.size, false)

        wizarding_school_populated.sort new_students

        # find new students in whatever house they were sorted into
        wizarding_school_populated.houses.each do |house|
          found_students_tracker.each_with_index do |was_found, i|
            if ( !was_found && house.students.include?(new_students[i]) )
              found_students_tracker[i] = true
            end
          end
        end

        expect(found_students_tracker.all?).to eq true
      end
    end

    context '#house_cup_standings' do
      it 'returns the current standings of the house cup' do
        school = wizarding_school_populated
        professors = school.professors

        expected_house_cup_standings = []

        # simulate teachers awarding points to houses
        school.houses.each_with_index do |house, i|
          professors.first.award i, house
          expected_house_cup_standings << [house.name, house.points]
        end
        expected_house_cup_standings.reverse!

        expect(school.house_cup_standings).to eq expected_house_cup_standings
      end
    end

    context '#house_cup_winner' do
      it 'returns the winner of the house cup' do
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

  end
end
