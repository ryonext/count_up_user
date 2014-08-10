require './settings'
require 'redis'

task :summary do
  redis = Redis.new(host: Settings.redis_host)
  today = Date.today
  # 昨日のログインユーザ
  last_login_count = redis.scard("launch_#{today - 1}")
  # 2日連続ログインユーザ
  two_seq_login_count = redis.sinter("launch_#{today - 1}", "launch_#{today - 2}").count
  # 3日連続ログインユーザ
  three_seq_login_count = redis.sinter("launch_#{today - 1}", "launch_#{today - 2}", "launch_#{today - 3}").count
  puts last_login_count
  puts two_seq_login_count
  puts three_seq_login_count
end
