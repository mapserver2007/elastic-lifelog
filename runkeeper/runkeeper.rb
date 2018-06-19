# -*- coding: utf-8 -*-
require "health_graph"
require 'optparse'
require 'csv'
require 'date'

params = ARGV.getopts("t:", "n:")
user = HealthGraph::User.new(params['t'])

csv_data = CSV.generate(force_quotes: true) do |csv|
  user.fitness_activities(pageSize: params['n']).items.each do |e|
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

File.open("data/runkeeper_export.csv", 'w') do |file|
  file.write(csv_data)
end
