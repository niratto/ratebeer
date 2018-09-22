# frozen_string_literal: true

class User < ApplicationRecord
    require 'ratings_average'
    include RatingAverage
    validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
    has_many :ratings

  def to_s
    username.to_s
    end
end
