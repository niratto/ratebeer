# frozen_string_literal: true

class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.hour) { get_places_in(city) }
  end

  def self.bar_info(id)
    Rails.cache.fetch(id, expires_in: 1.hour) { get_bar_info(id) }
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response['bmp_locations']['location']

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.get_bar_info(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"

    print("**** " + url + " ******")
    response = HTTParty.get "#{url}#{id}"
    info = response.parsed_response['bmp_locations']['location']

    return [] if info.is_a?(Hash) && info['id'].nil?

    info = [info] if info.is_a?(Hash)
    info.map do |data|
      Place.new(data)
    end
  end


  def self.key
    raise "BEERMAPPING_APIKEY env variable not defined" if ENV['BEERMAPPING_APIKEY'].nil?
    ENV['BEERMAPPING_APIKEY']
  end
end
