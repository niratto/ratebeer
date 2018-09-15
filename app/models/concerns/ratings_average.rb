module RatingAverage
    extend ActiveSupport::Concern
    def average_rating(what)
            
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

        
        what + " has " + y.to_s + " " + "rating".pluralize(y) + " with an average of " + x.to_s
    end
end