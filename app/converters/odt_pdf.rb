class OdtPdf < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=pdf #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'pdf'
  end
  
end