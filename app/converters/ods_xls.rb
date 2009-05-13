class OdsXls < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=xls #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'xls'
  end
  
end