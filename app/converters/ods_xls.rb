class OdsXls < Base
  
  def command
    `unoconv -p 2002 --format=xls #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'xls'
  end
  
end