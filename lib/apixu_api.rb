# frozen_string_literal: true

# http://api.apixu.com/v1/current.xml?key=b6d40dc1db5040a68f1205945180510&q=helsinki

class ApixuApi
  def self.weather_in(city)
    city = city.downcase
    key = "weather_" + city
    Rails.cache.fetch(key, expires_in: 1.hour) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.apixu.com/v1/current.xml?key=#{key}&q="
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    weather = response.parsed_response['root']

    return [] if weather.is_a?(Hash) && weather['location'].nil?

    weather = [weather] if weather.is_a?(Hash)
    weather.map do |data|
      Weather.new(data)
    end
  end

  def self.key
    raise 'APIXU_APIKEY env variable not defined' if ENV['APIXU_APIKEY'].nil?

    ENV['APIXU_APIKEY']
  end
end
