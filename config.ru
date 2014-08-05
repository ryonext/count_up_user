require 'rubygems'
require 'sinatra/base'
require 'json'
require 'redis'
require 'sinatra/reloader'

class LaunchApi < Sinatra::Base
  post '/' do
    user_id = params["user_id"]
    puts params
    redis = Redis.new
    today = Time.now.strftime('%Y%m%d')
    redis.sadd("launch_#{today}", user_id)
  end
end
run LaunchApi
