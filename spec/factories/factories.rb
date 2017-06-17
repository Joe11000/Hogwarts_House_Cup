require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :wizard do
    initialize_with { new() }


    factory :wizard_populated do
      wizard_name { Faker::HarryPotter.character }

      initialize_with { new({name: wizard_name}) }
    end
  end

  factory :house do
    initialize_with {
      new()
    }

    factory :house_populated do
      house_name { Faker::HarryPotter.house }
      founder { build(:wizard_populated) }
      wizards { 3.times.collect { build(:wizard_populated) }}

      initialize_with { new({name: house_name,
                             wizards: wizards,
                             founder: founder
                            })
                      }
    end
  end

  factory :wizarding_school do
    initialize_with {
      new()
    }

    factory :wizarding_school_populated do
      houses { 3.times.collect { build(:house_populated) } }
      head_master { build(:wizard_populated) }
      professors { 3.times.collect { build(:wizard_populated) } }

      initialize_with {
        new({ houses: houses,
              head_master: head_master,
              professors: professors
           })
      }
    end
  end
end
