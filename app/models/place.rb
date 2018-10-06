# frozen_string_literal: true

class Place < OpenStruct
  def self.rendered_fields1
    %i[name overall]
    # [id status street city zip country overall]
  end

  def self.rendered_fields2
    %i[name status street city zip country]
    # [id status street city zip country overall]
  end
end
