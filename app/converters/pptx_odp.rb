class PptxOdp < Base
  
  def command
    `OdfConverter /i #{self.master_filename}`
  end
  
  def from
    'pptx'
  end
  
  def to
    'odp'
  end
  
end