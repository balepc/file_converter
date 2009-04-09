class XlsOds < Base
  
  def command
    `unoconv -p 2002 --format=ods #{self.master_filename}`
  end
  
  def from
    'xls'
  end
  
  def to
    'ods'
  end
  
end