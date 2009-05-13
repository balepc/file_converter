class OdsCsv < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=csv #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'csv'
  end
  
end