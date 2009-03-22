require 'converters/base'

class OdtPdf < Base
  
  def command
    `unoconv -p 2002 --format=pdf #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'pdf'
  end
  
end