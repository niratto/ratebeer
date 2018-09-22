# frozen_string_literal: true

# top level comment
class Beer < ApplicationRecord
  require 'ratings_average'
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: TRUE

  def to_s
    "#{brewery.name}: #{name}"
  end

  def average
    return 0 if ratings.count.zero?

    ratings.map(&:score).sum / ratings.count.to_f
  end
end

# top level comment
# class Rating < ApplicationRecord
#  belongs_to :beer
# end
