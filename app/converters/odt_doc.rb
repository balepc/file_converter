require 'converters/base'

class OdtDoc < Base
  
  def command
    `unoconv --format=doc #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'doc'
  end
  
end