require 'dotenv'
require 'httparty'

Dotenv.load
BASE_URL = 'https://us1.locationiq.com/v1/search.php'

seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]
seven_wonders_hash = Hash.new(0)

seven_wonders.map do |wonder|
  query_parameters = {
    key: ENV['KEY'],
    q: wonder,
    format: 'json'
  }
  response = HTTParty.get(BASE_URL, query: query_parameters)[0]
  sleep(0.25)
  seven_wonders_hash[wonder] = {
    'lat' => response['lat'],
    'lng' => response['lon']
  }
end

puts seven_wonders_hash

#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
