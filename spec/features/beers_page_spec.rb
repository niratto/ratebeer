# frozen_string_literal: true

require 'rails_helper'

include Helpers

describe 'Beer' do
  let!(:brewery) { FactoryBot.create :brewery, name: 'Koff' }
  # let!(:beer1) { FactoryBot.create :beer, name: '', brewery: brewery }
  # let!(:beer2) { FactoryBot.create :beer, name: 'Karhu', brewery: brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it 'with a non-empty name, style and brewery is created' do
    visit new_beer_path

    
    fill_in('beer_name', with: 'New Beer')
    expect do
      click_button('Create Beer')
    end.to change { Beer.count }.by(1)
  end

  it 'must have a name when created' do
    visit new_beer_path

    expect do
      click_button('Create Beer')
    end.to change { Beer.count }.by(0)

    expect(page).to have_content "Name can't be blank"

    #    save_and_open_page
  end
end
