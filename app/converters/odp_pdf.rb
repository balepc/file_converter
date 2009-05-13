class OdpPdf < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=pdf #{self.master_filename}`
  end
  
  def from
    'odp'
  end
  
  def to
    'pdf'
  end
  
end