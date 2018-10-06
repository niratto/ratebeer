# frozen_string_literal: true

require 'rails_helper'

describe 'Places' do
  it 'if one is returned by the API, it is shown at the page' do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
      [Place.new(name: 'Oljenkorsi', id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
  end

  it 'if multiple bars are shown, verify that all of them are shown' do
    myPlace = 'helsinki'
    @places = BeermappingApi.places_in(myPlace)

    visit places_path
    fill_in('city', with: 'Helsinki')
    click_button 'Search'

    @places.map do |place|
      placeNow = place.name
      expect(page).to have_content placeNow
    end
  end

  it 'if no bars are shown, verify that no locations for... -message is shown' do
    myPlace = 'vantaa'
    @places = BeermappingApi.places_in(myPlace)

    visit places_path
    fill_in('city', with: myPlace)
    click_button 'Search'

    expect(page).to have_content 'No locations in ' + myPlace if @places.empty?
  end
end
