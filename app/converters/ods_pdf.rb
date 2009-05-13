class OdsPdf < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=pdf #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'pdf'
  end
  
end