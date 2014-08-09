require 'rubygems'
require 'sinatra/base'
require 'json'
require 'redis'
if ENV['RACK_ENV'] == 'development'
  require 'sinatra/reloader'
  require 'pry'
  require './settings'
end

class LaunchApi < Sinatra::Base
  post Settings.post_path do
    user_id = params[Settings.id_key]
    redis = Redis.new(host: Settings.redis_host)
    today = Time.now.strftime('%Y%m%d')
    redis.sadd("launch_#{today}", user_id)
  end
end
run LaunchApi
