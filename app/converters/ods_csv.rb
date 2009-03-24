class OdsCsv < Base
  
  def command
    `unoconv -p 2002 --format=csv #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'csv'
  end
  
end