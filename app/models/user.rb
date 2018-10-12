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
                       length: { minimum: 3 }

  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: 'must contain one capital letter and number'
                       }

  def self.most_active(n)
    most_active_in_asc_order = User.all.sort_by { |u| -(u.ratings.count || 0) }.first(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
  end

  def to_s
    "#{username}"
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
   end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by { |r| r.beer.style }
    averages = style_ratings.map do |style, ratings|
      { style: style, score: average_of(ratings) }
    end

    averages.max_by { |r| r[:score] }[:style]
  end

  def favorite_brewery
    return nil if ratings.empty?

    style_ratings = ratings.group_by { |r| r.beer.brewery }
    averages = style_ratings.map do |brewery, ratings|
      { brewery: brewery, score: average_of(ratings) }
    end

    averages.max_by { |r| r[:score] }[:brewery]
  end
end
