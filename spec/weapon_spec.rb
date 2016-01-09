require 'spec_helper'
require 'weapon'

describe Weapon do


  let(:weapon) { Weapon.new("FooWeapon", 10) }


  describe '#initialize' do


    it 'raises an ArgumentError if name and damage are not provided' do
      expect { Weapon.new }.to raise_error(ArgumentError)
    end


    it "has a name attribute" do
      expect(weapon.name).to eq("FooWeapon")
    end


    it "is given a damage value" do
      expect(weapon.damage).to eq(10)
    end


    it 'has an unchangeable name' do
      expect(weapon).to_not respond_to(:name=)
    end


    it 'has an unchangeable damage value' do
      expect(weapon).to_not respond_to(:damage=)
    end

    
  end
end

