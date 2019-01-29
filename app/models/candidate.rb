# This class handles the communication between GoogleSheetService and TalkpushService,
# also manage the Canditate attributes validation
class Candidate
    include ActiveModel::Model
    attr_accessor :first_name, :last_name, :email, :user_phone_number
    validates :first_name, :last_name, :email, :user_phone_number, presence: true
    
    # Calls the GoogleSheetsService in order to get last candidates added
    # Params:
    # - filter: last update timestamp to filter the candidates query
    def self.get_candidates(filter)
        response = @@google_sheets_service.get_candidates(filter)
        @@google_sheets_service.parse_response(response)
    end

    # Calls the TalkpushService in order to send each candidate
    # to Talkpush API, if it's a Candidate valid obj
    def self.send_candidates
        filter = last_update == "" ? Rails.configuration.start_date : last_update
        candidates = get_candidates(filter)
        candidates.each do |candidate|
            newCandidate = Candidate.new(:first_name => candidate[:name], :last_name => candidate[:lastname], :email => candidate[:email], :user_phone_number => candidate[:phone_number])
            if newCandidate.valid?
                response = @@talkpush_service.create_candidate(newCandidate)
                unless response.code != 200
                    # Logs the candidates timestamps in sync.log
                    # in order to know the last update for the next sync
                    sync_logger.info(candidate[:timestamp])
                    # Logs candidates data in candidates.log
                    # in order to keep tracking the updates
                    candidates_logger.info(candidate)
                end
            end
        end
    end
    
    def persisted?
      false
    end

    # Creates logger file to keep track of every sync timestamp
    def self.sync_logger
        @@sync_logger ||= Logger.new(Rails.configuration.sync_logger)
        @@sync_logger.formatter = proc do |severity, datetime, progname, msg|
            "#{msg}\n"
        end
        @@sync_logger
    end

    # Creates logger file to keep track of every candidate processed 
    def self.candidates_logger
        @@candidates_logger ||= Logger.new(Rails.configuration.candidates_logger)
        @@candidates_logger.formatter = proc do |severity, datetime, progname, msg|
            "#{msg}\n"
        end
        @@candidates_logger
    end

    # Gets the last timestamp in sync.log
    # to use it in next sync
    def self.last_update
        `tail -n 1 #{Rails.configuration.sync_logger}`
    end

    # Instance for GoogleSheetService
    @@google_sheets_service = GoogleSheetsService
    # Instance for TalkpushService
    @@talkpush_service = TalkpushService
  end