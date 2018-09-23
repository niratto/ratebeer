# frozen_string_literal: true

# top level comment
class User < ApplicationRecord
  require 'ratings_average'
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validate :check_password_format
  has_many :ratings
  has_many :beers, through: :ratings

  def to_s
    username.to_s
  end

  def check_password_format
    regexps = { ' must contain at least one lowercase letter' => /[a-z]+/,
                ' must contain at least one uppercase letter' => /[A-Z]+/,
                ' must contain at least one digit' => /\d+/,
                ' must contain at least one special character' => /[^A-Za-z0-9]+/,
                ' must be at least 4 characters long' => /.{4,}/ }
    regexps.each do |rule, reg|
      errors.add(:password, rule) unless password.match(reg)
    end
  end
end
