RAILS_ROOT = File.dirname(File.dirname(__FILE__))

def generic_monitoring(w, options = {})
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 10.seconds
      c.running = false
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = options[:memory_limit]
      c.times = [3, 5] # 3 out of 5 intervals
    end
  
    restart.condition(:cpu_usage) do |c|
      c.above = options[:cpu_limit]
      c.times = 5
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end

God.watch do |w|
  script = "soffice -headless -norestore \"-accept=socket,host=localhost,port=2002;urp\" && pidof soffice.bin > #{RAILS_ROOT}/log/soffice.pid"
  w.name = "soffice"
  w.group = "converters"
  w.interval = 60.seconds

  w.start = "#{script}"
  w.stop = "killall -v soffice.bin"

  w.start_grace = 5.seconds
  w.restart_grace = 5.seconds

  w.pid_file = "#{RAILS_ROOT}/log/soffice.pid"
  w.behavior(:clean_pid_file)
  
  generic_monitoring(w, :cpu_limit => 80.percent, :memory_limit => 400.megabytes)
end