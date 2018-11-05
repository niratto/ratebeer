# frozen_string_literal: true

json.extract! brewery, :name, :year, :beers, :active
json.url brewery_url(brewery, format: :json)
