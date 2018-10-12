# frozen_string_literal: true

#
class Style < ApplicationRecord
  has_many :beers

  def to_s
    name.to_s
  end
end
