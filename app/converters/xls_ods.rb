class XlsOds < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=ods #{self.master_filename}`
  end
  
  def from
    'xls'
  end
  
  def to
    'ods'
  end
  
end