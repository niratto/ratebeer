class Rating < ApplicationRecord
    belongs_to :beer
    
    # to_s aina välillä lakkaa toimimasta ja alkoi ärsyttää
    # siksi uudelleennimesin tämän metodin...
    def to_string
        "#{beer.name} #{score}"
    end

    def average
        
    end
end
