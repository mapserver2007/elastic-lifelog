# -*- coding: utf-8 -*-
require "health_graph"
require 'optparse'
require 'csv'
require 'date'
require 'yaml'

token = YAML.load_file(File.dirname(__FILE__) + '/config/token.yml')

user = HealthGraph::User.new(token['access_token'])
num = 2000

csv_data = CSV.generate(force_quotes: true) do |csv|
  user.fitness_activities(pageSize: num).items.each do |e|
    next unless e.type == 'Running'
    date = DateTime.parse(e.start_time)
    distance_km = (e.total_distance / 1000).to_f.round(2)
    duration_min = (e.duration / 60).to_f.round()
    csv << [
      date.to_s,
      distance_km,
      duration_min,
      e.total_calories
    ]
  end
end

File.open("#{File.dirname(__FILE__)}/data/runkeeper_export.csv", 'w') do |file|
  file.write(csv_data)
end
