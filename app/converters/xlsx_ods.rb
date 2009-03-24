class XlsxOds < Base
  
  def command
    `OdfConverter /i #{self.master_filename}`
  end
  
  def from
    'xlsx'
  end
  
  def to
    'ods'
  end
  
end