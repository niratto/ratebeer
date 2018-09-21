# frozen_string_literal: true

class User < ApplicationRecord
    require 'ratings_average'
    include RatingAverage
    has_many :ratings

  def to_s
    username.to_s
    end
end
