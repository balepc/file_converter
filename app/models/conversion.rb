require 'converters/docx_odt'
require 'converters/odt_doc'

class Conversion < ActiveRecord::Base
  
  DOCX_FORMAT = 'docx'
  
  has_attachment :path_prefix => 'public/assets',
    :max_size => 100.megabytes
  
  after_save :do_convertions
  
  private
  
  def validate
    self.errors.add(:content_type, 'Unsupported') unless valid_format?
  end
  
  def valid_format?
    self.content_type == DOCX_FORMAT or (self.filename and self.filename.include?('docx'))
  end
  
  def do_convertions
    return unless valid_format?
    return if converted?
    timer = Time.now
      odt = DocxOdt.new(self.full_filename)
      odt.convert!

      doc = OdtDoc.new(odt.child_filename)
      doc.convert!

      odt.destroy_master
      odt.destroy_child
    self.converted = true
    self.spent = Time.now - timer
    self.save
  end
  
end
