class ConvException < ActiveRecord::Base
  
  belongs_to :conversion
  
  before_save :detect_exception_type
  
  UNKNOWN = 0
  SMALL_SIZE = 1
  UNSUPPORTED_FORMAT = 2
  
  private
  def detect_exception_type
    if conversion and (asset = conversion.asset)
      self.exception_type = SMALL_SIZE if asset.size.to_i < 4048
      self.exception_type = UNSUPPORTED_FORMAT unless asset.valid_from_format?
    end
    self.exception_type ||= UNKNOWN
  end
  
end
