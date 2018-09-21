# frozen_string_literal: true

# top level comment
class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user
  # to_s sometimes didn't work so that's why this method is created
  def to_s
    " #{beer.name} #{score}"
  end

  def rated_by
    "#{user.username}"
  end

  def average; end
end
