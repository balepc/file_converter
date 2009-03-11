module ConvProcess
  
  def self.restart_soffice
    `killall -v oosplash.bin`
    `killall -v soffice.bin`
    exec('soffice -headless -norestore "-accept=socket,host=localhost,port=2002;urp" &')
  end
  
  def self.can_restart_soffice?
    true
  end
  
end