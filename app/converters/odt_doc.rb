class OdtDoc < Base
  
  def command
    `unoconv -p 2002 --format=doc #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'doc'
  end
  
end