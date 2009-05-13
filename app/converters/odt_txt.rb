class OdtTxt < Base
  
  def command
    `unoconv -p #{UnoconvPort.port} --format=txt #{self.master_filename}`
  end
  
  def from
    'odt'
  end
  
  def to
    'txt'
  end
  
end