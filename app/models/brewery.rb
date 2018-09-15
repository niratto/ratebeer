class Brewery < ApplicationRecord
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def to_s
        "#{name}"
	end

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2018
		puts "changed year to #{year}"
	end

	def average_rating
		
		ratings_array = ratings.map(&:score)
		#sum = 0
		#counter = 0
		#for score in ratings_array
		#	sum = sum + score
		#	counter = counter + 1
		#end

		#sum / counter
		
		x = ratings_array.inject{ |sum, el| sum + el }.to_f / ratings_array.size
		y = ratings_array.size

		
		"Brewery has " + y.to_s + " " + "rating".pluralize(y) + " with an average of " + x.to_s
end
end
