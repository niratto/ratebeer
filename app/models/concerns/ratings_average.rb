# frozen_string_literal: true

# top level comment
module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    # keskiarvo on mahdollista laskea myös suoraan ActiveRecordilla
    # ratings.average(:score)
    ratings.reduce(0.0){ |sum, r| sum + r.score } / ratings.count
  end
end

#module RatingAverage
#  extend ActiveSupport::Concern
#  def average_rating(what)
#    ratings_array = ratings.map(&:score)
#    x = ratings_array.inject { |sum, el| sum + el }.to_f / ratings_array.size
#    y = ratings_array.size
#
#    what + y.to_s + ' ' + 'rating'.pluralize(y) +
#      ' with an average of ' + x.to_s
#  end
#end
