# -*- coding: utf-8 -*-
require 'lastfm'
require 'yaml'
require 'launchy'

def color str, num
  "\e[#{num}m#{str}\e[0m"
end

config = YAML.load_file(File.dirname(__FILE__) + '/config/token.yml')
lastfm = Lastfm.new(config['key'], config['secret'])
puts "http://www.last.fm/api/auth/?api_key=#{config['key']}&cb=http%3A%2F%2Flocalhost%3A9292"
print color("token: ", 32)
puts "session_key: " + lastfm.auth.get_session(:token => gets)["key"]
