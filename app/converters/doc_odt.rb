class DocOdt < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=odt #{self.master_filename}`
  end
  
  def from
    'doc'
  end
  
  def to
    'odt'
  end
  
end