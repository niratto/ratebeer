# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has the username set correctly' do
    user = User.new username: 'Pekka'

    expect(user.username).to eq('Pekka')
  end

  it 'is not saved without a password' do
    user = User.create username: 'Pekka'

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe 'with too short password' do
    let(:user) { User.create username: 'Pekka', password: 'xyz', password_confirmation: 'xyz' }

    it 'is not saved' do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe 'with a password without number(s)' do
    let(:user) { User.create username: 'Pekka', password: 'WithoutNumbers', password_confirmation: 'WithoutNumbers' }

    it 'is not saved' do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe "with a password that doesn't match confirmation" do
    let(:user) { User.create username: 'Pekka', password: 'Password1', password_confirmation: 'Password2' }

    it 'is not saved' do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe 'with a proper password' do
    let(:user) { FactoryBot.create(:user) }

    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it 'and with two ratings, has the correct average rating' do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating('')).to eq('2 ratings with an average of 15.0')
    end
  end

  it 'has method for determining the favorite_beer' do
    user = FactoryBot.create(:user)
    expect(user).to respond_to(:favorite_beer)
  end

  describe 'favorite beer' do
    let(:user) { FactoryBot.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_beer)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil)
    end
  end

  it 'is the only rated if only one rating' do
    user = FactoryBot.create(:user)
    beer = FactoryBot.create(:beer)
    rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

    expect(user.favorite_beer).to eq(beer)
  end

  it 'is the one with highest rating if several rated' do
    user = FactoryBot.create(:user)
    create_beer_with_rating({ user: user }, 10)
    create_beer_with_rating({ user: user }, 7)
    best = create_beer_with_rating({ user: user }, 25)

    expect(user.favorite_beer).to eq(best)
  end

  describe 'favorite beer' do
    let(:user) { FactoryBot.create(:user) }

    it 'has method for determining one' do
      expect(user).to respond_to(:favorite_beer)
    end

    it 'without ratings does not have one' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beers_with_many_ratings({ user: user }, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end
end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end
