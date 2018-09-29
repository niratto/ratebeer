# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'with a style,name and brewery' do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:beer) { Beer.create name: 'testbeer', style: 'teststyle', brewery: test_brewery }

    it 'is saved' do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe 'with style and brewery BUT no name' do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:beer) { Beer.create name: '', style: 'teststyle', brewery: test_brewery }

    it 'is not saved' do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

  describe 'with a name and brewery BUT no style' do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:beer) { Beer.create name: 'testbeer', style: '', brewery: test_brewery }

    it 'is not saved' do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
