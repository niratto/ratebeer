# frozen_string_literal: true

# top level comment
class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: TRUE
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: 2018,
                                    only_integer: true }
  

  def to_s
    name.to_s
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def average_rating
    ratings_array = ratings.map(&:score)

    x = ratings_array.inject { |sum, el| sum + el }.to_f / ratings_array.size
    y = ratings_array.size

    'Brewery has ' + y.to_s + ' ' + 'rating'.pluralize(y) +
      ' with an average of ' + x.to_s
  end
end
