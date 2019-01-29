require 'test_helper'

class GoogleSheetsServiceTest < ActiveSupport::TestCase

  # Tests data retrieved from Google API
  test "get candidates" do

    # Datetime format timestamp in Google sheet
    timestamp = "01/20/2019 8:45:15"
    # Calls Google API
    response = @@google_sheets_service.get_candidates(timestamp)
    assert_equal( 200, response.code)
  end

  # Tests timestamp formatting
  test "custom date query param" do
    # Datetime format timestamp in Google sheet
    timestamp = "01/20/2019 8:45:15"
    # Datetime expected for Google Visualization API Query Language 
    expected = "2019-01-20%208%3A45%3A16"
    # Parses timestamp in a readble format for Google Visualization API Query Language
    result = @@google_sheets_service.custom_date_query_param(timestamp)
    assert_equal( expected, result)
  end

  @@google_sheets_service = GoogleSheetsService
end
