# frozen_string_literal: true

# top level comment
class User < ApplicationRecord
  require 'ratings_average'

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: 'must contain one capital letter and number'
                       }

  def to_s
    username.to_s
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
end
