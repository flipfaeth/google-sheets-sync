# This class handles the communication to Talkpush API
class TalkpushService
     # Talkpush API base uri
    @@base_uri = 'https://my.talkpush.com/api/talkpush_services/campaigns/'

    # Sets the POST body as expected for Talkpush enpoint
    # Add the Talkpush keys and the candidate data
    def self.set_body(candidate)
        @body = {
            api_key: Rails.configuration.talkpush_api_key, 
            api_secret: Rails.configuration.talkpush_api_secret, 
            campaign_invitation: {
                first_name: candidate.first_name,
                last_name: candidate.last_name,
                email: candidate.email,
                user_phone_number: candidate.user_phone_number
            }
        }.to_json
    end

    # Post candidate to Talkpush API
    # Params:
    # - candidate: Candidate valid obj
    def self.create_candidate(candidate)
        url = @@base_uri + Rails.configuration.talkpush_campaign_id.to_s + "/campaign_invitations"
        set_body(candidate)
        response = HTTParty.post(url, body: @body, headers: { 'Content-Type' => 'application/json', 'Cache-Control' => 'no-cache' } )
        response
    end

end