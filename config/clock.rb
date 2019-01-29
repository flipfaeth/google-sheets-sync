require 'clockwork'
require './config/boot'
require './config/environment'

require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

# Triggers the Sync candidate process that checks for new data
# in Google sheet and send the data to Talkpush API 
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  Clockwork.every(Rails.configuration.sync_minutes.minutes, 'Sync candidates') { Candidate.send_candidates }
end