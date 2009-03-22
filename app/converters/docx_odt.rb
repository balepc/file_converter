require 'converters/base'

class DocxOdt < Base
  
  def command
    `OdfConverter /i #{self.master_filename}`
  end
  
  def from
    'docx'
  end
  
  def to
    'odt'
  end
  
end