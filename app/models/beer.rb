class Beer < ApplicationRecord
	require "ratings_average"
	include RatingAverage
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
        "#{brewery.name}: #{name}"
	end
	
	#def average_rating
		
	#		ratings_array = ratings.map(&:score)
			#sum = 0
			#counter = 0
			#for score in ratings_array
			#	sum = sum + score
			#	counter = counter + 1
			#end

			#sum / counter
			
	#		x = ratings_array.inject{ |sum, el| sum + el }.to_f / ratings_array.size
	#		y = ratings_array.size

			
	#		"Beer has " + y.to_s + " " + "rating".pluralize(y) + " with an average of " + x.to_s
	#end
  end
  
  class Rating < ApplicationRecord
	belongs_to :beer
  end