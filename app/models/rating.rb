# frozen_string_literal: true

# top level comment
class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  # to_s sometimes didn't work so that's why this method is created
  def to_s
    " #{beer.name} #{score}"
  end

  def rated_by
    user.username.to_s
  end

  def average; end
end
