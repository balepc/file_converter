class OdtRtf < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=rtf #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'rtf'
  end
  
end