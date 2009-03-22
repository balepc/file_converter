require 'converters/docx_odt'
require 'converters/odt_doc'
require 'converters/odt_txt'
require 'converters/odt_pdf'

class Conversion < ActiveRecord::Base

  belongs_to :asset, :foreign_key => :asset_from_id
  validates_presence_of :from
  validates_presence_of :to
   
  attr_accessor :to_format
  
  def Conversion.convert(asset, to_format)
    unless (existing = Conversion.find(:first, :conditions => ["asset_from_id=? AND `conversions`.from=? AND `conversions`.to=?", asset.id, asset.asset_type.code, to_format]))
      conv = Conversion.new(:asset => asset, :to_format => to_format)
      conv.convert
      conv
    else
      existing
    end
  end
  
  def convert
    return false if not valid_format? or not valid_transition?
    return false if converted?
    
    timer = Time.now
    
      do_convertions
      
    self.spent = Time.now - timer
    
    self.converted = true
    self.save
    
  rescue FormatException => ex
    
    self.exception = ex.message
    self.converted = false
    false
  end
  
  def result_filename
    self.asset.full_filename.gsub(/#{self.from}$/, self.to)
  end
  
  private
  def valid_format?
    self.asset.valid_from_format?
  end
  
  def valid_transition?
    from = self.asset.asset_type 
    to = AssetType.find_by_code(self.to_format)
    
    self.from ||= from.code
    self.to ||= to.code
    
    from.converts?(to)
  end
  
  def docx_to_doc?
    self.asset.asset_type.docx? and AssetType.find_by_code(self.to_format).doc?
  end
  
  def docx_to_pdf?
    self.asset.asset_type.docx? and AssetType.find_by_code(self.to_format).pdf?
  end
  
  def docx_to_txt?
    self.asset.asset_type.docx? and AssetType.find_by_code(self.to_format).txt?
  end
  
  def docx_to_odt?
    self.asset.asset_type.docx? and AssetType.find_by_code(self.to_format).odt?
  end
  
  def do_convertions
    if docx_to_doc?
      if (conv = Conversion.convert(self.asset, 'odt'))
        doc = OdtDoc.new(conv.result_filename)
        doc.convert!
      end
    elsif docx_to_pdf?
      if (conv = Conversion.convert(self.asset, 'odt'))
        doc = OdtPdf.new(conv.result_filename)
        doc.convert!
      end
    elsif docx_to_txt?
      if (conv = Conversion.convert(self.asset, 'odt'))
        doc = OdtTxt.new(conv.result_filename)
        doc.convert!
      end
    elsif docx_to_odt?
      odt = DocxOdt.new(self.asset.full_filename)
      odt.convert!
    end
  end
  
end
