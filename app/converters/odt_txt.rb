require 'converters/base'

class OdtTxt < Base
  
  def command
    `unoconv -p 2002 --format=txt #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'txt'
  end
  
end