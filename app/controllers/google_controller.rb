class GoogleController < ApplicationController

    def get_sheet_data
		render json: Candidate.send_candidates, status: 200
    end
    
    
end
