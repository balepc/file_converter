class AssetType < ActiveRecord::Base
  
  @@conerters = {
    :docx => {
      :doc => ['odt', OdtDoc],
      :pdf => ['odt', OdtPdf],
      :txt => ['odt', OdtTxt],
      :odt => DocxOdt,
      :rtf => ['odt', OdtRtf]
    },
    :xlsx => {
      :xls => ['ods', OdsXls],
      :csv => ['ods', OdsCsv],
      :ods => XlsxOds,
      :pdf => ['ods', OdsPdf]
    },
    :pptx => {
      :ppt => ['odp', OdpPpt],
      :pdf => ['odp', OdpPdf],
      :odp => PptxOdp
    },
    :doc => {
      :odt => DocOdt,
      :docx => ['odt', OdtDocx]
    },
    :xls => {
      :ods => XlsOds,
      :xlsx => ['ods', OdsXlsx]
    }
  }
  
  validates_presence_of :mime_type
  validates_presence_of :code
  validates_uniqueness_of :mime_type
  
  def self.get_converter(from, to)
    @@conerters[from.to_sym][to.to_sym]
  end
  
  def valid_from_format?
    @@conerters[self.code.to_sym]
  end

end
