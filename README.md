# Google Sheets Sync

RoR app that sync google sheet data with the Talkpush CRM data.

* Ruby version

 - **ruby 2.6.0**

* Rails version

 - **Rails 5.2.2**

* Configuration vars
```
 # App custom config vars
 # Campaign start date. This is the date filter for the first read, 
 # after that, the app will not longer use it, 
 # because the app will use the last timestamp read
 # Format: "mm/dd/YYYY h:m:s"
 config.start_date = "01/28/2019 00:00:00"
 # Minutes between each sync
 config.sync_minutes = 1

 # Google API config vars
 config.google_api_key = "Google API key"
 config.google_sheet_id = "Google Sheet id"

 # Talkpush API config vars
 config.talkpush_api_key = "Talkpush API key"
 config.talkpush_api_secret = "Talkpush API secret"
 config.talkpush_campaign_id = 0000 # Talkpush campaign id
```

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

```
- Clone the repo.
- Run the command 'bundle install'.
- Add Google key and sheet id in the enviroment file.
- Add Talkpush keys and campaign id in the enviroment file.
- Run 'clockwork config/clock.rb'.
```

* Running the test
```
- rake test
```
