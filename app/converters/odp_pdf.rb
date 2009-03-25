class OdpPdf < Base
  
  def command
    `unoconv -p 2002 --format=pdf #{self.master_filename}`
  end
  
  def from
    'odp'
  end
  
  def to
    'pdf'
  end
  
end