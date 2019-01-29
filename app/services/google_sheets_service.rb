# This class handles the communication to Google API
class GoogleSheetsService
    # Google API base uri
    @@base_uri = 'https://docs.google.com/a/google.com/spreadsheets/d/'

    # Gets the last added candidates in the Google sheet since last update
    # Params:
    # - last_update: last update timestamp to filter the candidates query
    def self.get_candidates(last_update)
        criteria = custom_date_query_param(last_update)
        response = HTTParty.get(@@base_uri + Rails.configuration.google_sheet_id.to_s + "/gviz/tq?tqx=csv:json&tq=select%20*%20where%20A%20%3E%20datetime%20'" + criteria + "'&key=" + Rails.configuration.google_api_key)
        response
    end

    # Parses the Google Visualization response to a readble json object.
    # Params:
    # - reponse: Google Visualization response get it from Google API call
    def self.parse_response(response)
        result = []
        unless response.code != 200
            response = response.gsub('/*O_o*/', '')
            response = response.gsub('google.visualization.Query.setResponse(', '')
            response = response.gsub!("\n", '')
            response = response.gsub(');', '')
            response = response.gsub(/\"/, "\'")
            response = response.gsub(/'/, '"')
            response = JSON.parse(response)
            rows = response["table"]["rows"]
            rows.each do |row|
                result.push({
                    timestamp: row["c"][0]["f"],
                    name: row["c"][1]["v"],
                    lastname: row["c"][2]["v"],
                    email: row["c"][3]["v"],
                    phone_number: row["c"][4]["f"]
                })
            end
        end
        result 
    end

    # Formats the timestamp to Google Visualization API Query Language string
    # Params:
    # - timestamp: last update timestamp criteria to use in the query
    def self.custom_date_query_param(timestamp)
        parts = timestamp.split(" ")
        date = Time.strptime(parts[0], "%m/%d/%Y")
        time = parts[1].to_time
        time = time + 1.seconds

        second = time.sec < 10 ? "0" + time.sec.to_s : time.sec.to_s
        minute = time.min < 10 ? "0" + time.min.to_s : time.min.to_s
        day = date.day < 10 ? "0" + date.day.to_s : date.day.to_s
        month = date.month < 10 ? "0" + date.month.to_s : date.month.to_s

        date.year.to_s + '-' + month + '-' + day + '%20' + time.hour.to_s + '%3A' + minute + '%3A' + second
    end

end