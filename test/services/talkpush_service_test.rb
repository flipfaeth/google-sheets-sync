require 'test_helper'
class TalkpushServiceServiceTest < ActiveSupport::TestCase
 
    # Tests candidates creation to Talkpush API
    test "create candidate" do

        # Test candidate obj
        candidate = Candidate.new(:first_name => "TestName", :last_name => "TestLastName", :email => "test@test.com", :user_phone_number => 1111111111)

        response = @@talkpush_service.create_candidate(candidate)
        assert_equal( 200, response.code)
    end

    @@talkpush_service = TalkpushService
end
