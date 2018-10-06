class Weather < OpenStruct
    def self.rendered_fields
        %i[temp_c]
    end
end