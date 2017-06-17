require_relative 'spec_helper'
require_relative '../lib/wizard'
require 'factory_girl'


RSpec.shared_examples 'A magical creature (Magicable Role)' do
  context 'class methods' do
    context '::info' do
      it 'returns information about the creature' do
        expect(described_class.info).to eq "A #{described_class.to_s.downcase} is a magical creature."
      end
    end
  end

  context "an instance on a Magicable Role's mixed in class" do
    context '#spells' do
      let(magical_being) { build(described_class.downcase.to_sym) }

      it "spells" do
        expect(magical_being.spells).to match_array ['Alohamora', 'Wingardium Leviosa'] + magical_being.local_spells
      end
    end

    context '#learn_spell' do
      let(magical_being) { build(described_class.downcase.to_sym) }

      it 'can learn new spells' do
        known_spells = magical_being.spells
        unknown_spell_name = 'unknown spell name'
        expect(magical_being.learn_spell unknown_spell_name).to eq (known_spells + unknown_spell_name)
      end

      it 'can not learn existing spells'
    end

    context 'local_spells' do

    end

    xcontext 'cast'
  end
end

RSpec.describe 'Anon inheriter of Magicable Role' do
  let(:magical_being) do
    class MagicalBeing; include Magicable; end;
    MagicalBeing.new
  end
    context 'local_spells' do
      it 'should be empty' do
        binding.pry
        expect(magical_being.local_spells).to eq []
      end
    end
end

# RSpec.describe Wizard do
#   it_behaves_like 'A magical creature (Magicable Role)'

#   it '' do
#     # Wizard.new.avada_kadavra
#   end
# end


