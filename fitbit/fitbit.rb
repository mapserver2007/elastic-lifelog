# -*- coding: utf-8 -*-
require 'fitbit_client'
require 'active_support/all'
require 'csv'
require 'yaml'

def get_timespan_list(year)
  timespan_list = []
  current = Date.today
  year.times do
    timespan_list << {
      start: Date.parse(current.strftime('%F')),
      end: Date.parse(current.prev_year.strftime('%F'))
    }
    current = current.prev_year
  end

  timespan_list
end

token = YAML.load_file(File.dirname(__FILE__) + '/config/token.yml')

client = FitbitClient::Client.new(
  token['access_token'],
  token['refresh_token'],
  {
    client_id: token['client_id'],
    client_secret: token['client_secret']
  }
)
timespan_list = get_timespan_list(5)
csv_data = CSV.generate(force_quotes: true) do |csv|
  timespan_list.each do |timespan|
    client.activity_time_series('steps', timespan[:start], timespan[:end])['activities-steps'].each do |activity|
      csv << [
        activity['dateTime'],
        activity['value']
      ]
    end
  end
end

File.open("#{File.dirname(__FILE__)}/data/fitbit_export.csv", 'w') do |file|
  file.write(csv_data)
end
