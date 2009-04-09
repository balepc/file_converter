require 'converters/base'

class OdtDocx < Base
  
  def command
    `OdfConverter /i #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'docx'
  end
  
end