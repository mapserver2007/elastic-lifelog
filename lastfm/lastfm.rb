# -*- coding: utf-8 -*-
require 'lastfm'
require 'yaml'
require 'csv'

config = YAML.load_file(File.dirname(__FILE__) + '/config/token.yml')
lastfm = Lastfm.new(config['key'], config['secret'])
lastfm.session = config['session_id']
user_id = config['user_id']
max_page = 20
limit_per_page = 1000

# artists
csv_data = CSV.generate(force_quotes: true) do |csv|
  1.upto(max_page) do |page|
    artists = lastfm.user.get_top_artists(user: user_id, period: "overall", page: page, limit: limit_per_page)
    break if artists.nil?
    artists.each do |artist|
      csv << [
        artist['rank'],
        artist['name'],
        artist['playcount']
      ]
    end
  end
end

File.open("#{File.dirname(__FILE__)}/data/lastfm_artist_export.csv", 'w') do |file|
  file.write(csv_data)
end

# tracks
csv_data = CSV.generate(force_quotes: true) do |csv|
  1.upto(max_page) do |page|
    tracks = lastfm.user.get_top_tracks(user: user_id, period: "overall", page: page, limit: limit_per_page)
    break if tracks.nil?
    tracks.each do |track|
      csv << [
        track['rank'],
        track['name'],
        track['artist']['name'],
        track['playcount']
      ]
    end
  end
end

File.open("#{File.dirname(__FILE__)}/data/lastfm_track_export.csv", 'w') do |file|
  file.write(csv_data)
end