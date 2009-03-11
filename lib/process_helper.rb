def pid_exists?(file_name)
  File.exists?(File.join(RAILS_ROOT, "/tmp/pids/#{file_name}"))
end
  
def create_pid(file_name, pid)
  Dir.mkdir(File.join(RAILS_ROOT, "/tmp/pids")) unless File.exists? File.join(RAILS_ROOT, "/tmp/pids")
  File.open(File.join(RAILS_ROOT, "/tmp/pids/#{file_name}"), 'w') do |f|
    f.puts pid
  end  
end
  
def destroy_pid(file_name)
  File.delete(File.join(RAILS_ROOT, "/tmp/pids/#{file_name}"))
end