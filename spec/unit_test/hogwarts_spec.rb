require_relative 'spec_helper'
require_relative '../lib/hogwarts'

RSpec.describe Wizard do
  it 'ff' do
    expect(Wizard.new).to be_a Wizard
  end
end
