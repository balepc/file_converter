class AssetType < ActiveRecord::Base
  
  @@conerters = {
    :docx => {
      :doc => ['odt', OdtDoc],
      :pdf => ['odt',OdtPdf],
      :txt => ['odt',OdtTxt],
      :odt => DocxOdt,
      :rtf => ['odt',OdtRtf]
    }
  }
  
  validates_presence_of :mime_type
  validates_presence_of :code
  
  def self.get_converter(from, to)
    @@conerters[from.to_sym][to.to_sym]
  end
  
  def valid_from_format?
    @@conerters[self.code.to_sym]
  end

end
