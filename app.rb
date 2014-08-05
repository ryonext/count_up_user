require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'redis'
require './settings'

post '/' do
  body = request.body.read
  param = JSON.parse(body)
  user_id = param["user_id"]
  redis = Redis.new
  today = Time.now.strftime('%Y%m%d')
  redis.sadd("launch_#{today}", user_id)
end
