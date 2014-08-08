worker_processes 2 # ワーカー数 CPU数 + α で良い
preload_app true

listen  '/tmp/unicorn.sock'
pid     '/tmp/unicorn.pid'

stderr_path File.expand_path('log/unicorn.log', "./")
stdout_path File.expand_path('log/unicorn.log', "./")


before_fork do |server, worker|
#  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  # 古いpidが残っていたら消す
  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
      rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
#  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
