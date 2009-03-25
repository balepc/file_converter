class OdpPpt < Base
  
  def command
    `unoconv -p 2002 --format=ppt #{self.master_filename}`
  end
  
  def from
    'odp'
  end
  
  def to
    'ppt'
  end
  
end