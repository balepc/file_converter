class OdtDoc < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=doc #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'doc'
  end
  
end