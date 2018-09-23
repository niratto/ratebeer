# frozen_string_literal: true

# top level coment
class ApplicationController < ActionController::Base    
    # määritellään, että metodi current_user tulee käyttöön myös näkymissä
    helper_method :current_user
    
    def current_user
        
        return nil if session[:user_id].nil?
        User.find(session[:user_id])
    end

#    def reset_session
#        @_request.reset_session
#      end
end
