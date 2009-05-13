require 'conv_process'

namespace :processes do
  
  desc "Check soffice process"
  task :soffice do
    try = 0
    while (not ConvProcess::can_restart_soffice? and try < 5 )do
      sleep(5)
      try += 1
      puts "Try #{try}"
    end
    ConvProcess::restart_soffice if ConvProcess::can_restart_soffice?
  end
  
end