module ConvProcess
  
  def self.restart_soffice
    `killall -v oosplash.bin`
    `killall -v soffice.bin`
    UnoconvPort::PORTS.each do |port|
      exec("soffice -headless -norestore \"-accept=socket,host=localhost,port=#{port};urp\" &")
    end
  end
  
  def self.can_restart_soffice?
    true
  end
  
end