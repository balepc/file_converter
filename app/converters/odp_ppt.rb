class OdpPpt < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=ppt #{self.master_filename}`
  end
  
  def from
    'odp'
  end
  
  def to
    'ppt'
  end
  
end