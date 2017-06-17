#!/usr/bin/env ruby
require 'pry'

# pretend there are multiple uses for this duck type
module Magicable
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def spells
      @spells ||= ['Alohamora', 'Wingardium Leviosa'] + local_spells
    end

    def learn_spell spell_name
      @spells << spell_name unless spells.include?(spell_name.capitalize)
    end

    def local_spells
      []
    end

    def cast spell_name=spells.try(:sample)
      "Casting #{spell_name}"
    end

    # def method_missing method_name
    #   binding.pry
    #   if spells.includes?(method_name)

    #   end
    # end
  end

  module ClassMethods
    def info
      "A #{self.to_s.downcase} is a magical creature."
    end
  end
end

class Wizard
  include Magicable

  attr_reader :name

  def initialize args=({name: ''})
    @name = args[:name]
    super()
  end

  def local_spells
    ['Apperate']
  end

  class << self
    def late
      "A #{self.to_s.downcase} is never late, nor is he early. He arrives persisely when he means to."
    end
  end
end





