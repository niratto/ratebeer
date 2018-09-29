# frozen_string_literal: true

require 'rails_helper'

include Helpers

describe 'Rating' do
  let!(:brewery) { FactoryBot.create :brewery, name: 'Koff' }
  let!(:beer1) { FactoryBot.create :beer, name: 'iso 3', brewery: brewery }
  let!(:beer2) { FactoryBot.create :beer, name: 'Karhu', brewery: brewery }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username: 'keijo' }

  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it 'when given, is registered to the beer and user who is signed in' do
    visit new_rating_path

    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect do
      click_button 'Create Rating'
    end.to change { Rating.count }.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating('')).to eq('1 rating with an average of 15.0')
  end

  it 'count existing ratings' do
    FactoryBot.create :rating, score: 10, beer: beer1, user: user
    FactoryBot.create :rating, score: 15, beer: beer2, user: user

    expect(user.ratings.count).to eq(2)
    visit ratings_path
  end

  it "user's own ratings" do
    FactoryBot.create :rating, score: 10, beer: beer1, user: user
    FactoryBot.create :rating, score: 15, beer: beer2, user: user
    FactoryBot.create :rating, score: 20, beer: beer2, user: user2

    visit ratings_path

    visit user_path(user)
  end

  it "delete user's own rating(s)" do
    FactoryBot.create :rating, score: 10, beer: beer1, user: user
    FactoryBot.create :rating, score: 15, beer: beer2, user: user
    FactoryBot.create :rating, score: 20, beer: beer2, user: user2

    visit ratings_path

    visit user_path(user)

    expect(user.ratings.count).to eq(2)

    find(:xpath, "(//a[@href[contains(.,'ratings')] and @data-method='delete'])[1]").click

    expect(user.ratings.count).to eq(1)
  end
end
