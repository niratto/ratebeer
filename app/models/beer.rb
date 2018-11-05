# frozen_string_literal: true

# top level comment
class Beer < ApplicationRecord
  require 'ratings_average'
  include RatingAverage
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  
  validates :name, presence: TRUE
  validates :style, presence: TRUE

  def to_s
    "#{brewery.name}: #{name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }.first(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
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
