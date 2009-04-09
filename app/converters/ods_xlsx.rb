class OdsXlsx < Base
  
  def command
    `OdfConverter /i #{self.master_filename}`
  end
  
  def from
    'ods'
  end
  
  def to
    'xlsx'
  end
  
end