# -*- coding: utf-8 -*-
require 'withings-sdk'
require 'csv'
require 'yaml'
require 'active_support/all'

token = YAML.load_file(File.dirname(__FILE__) + '/config/token.yml')
client = WithingsSDK::Client.new do |config|
  config.consumer_key        = token['key']
  config.consumer_secret     = token['secret']
  config.token               = token['access_token']
  config.secret              = token['access_token_secret']
end

end_date = Date.parse(Date.today.strftime('%F'))
start_date = '2010-01-01'

weight_list = client.weight(token['user_id'], { startdateymd: start_date, enddateymd: end_date })
csv_data = CSV.generate(force_quotes: true) do |csv|
  weight_list.each do |weight|
    csv << [
      Time.at(weight.weighed_at).strftime("%Y-%m-%d %H:%M:%S"),
      weight.in_kg
    ]
  end
end

File.open("#{File.dirname(__FILE__)}/data/withings_export.csv", 'w') do |file|
  file.write(csv_data)
end
