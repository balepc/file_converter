class Conversion < ActiveRecord::Base

  belongs_to :asset, :foreign_key => :asset_from_id
  has_many :conv_exceptions
  validates_presence_of :from
  validates_presence_of :to
  
  after_save :report_long_time
  
  def Conversion.convert(asset, to)
    from = asset.asset_type.code
    unless (existing = Conversion.find(:first, :conditions => ["asset_from_id=? AND `conversions`.from=? AND `conversions`.to=?", asset.id, from, to]))
      conv = Conversion.new(:asset => asset, :to => to, :from => from)
      conv.convert
    else
      existing
    end
  end
  
  def convert
    raise FormatException.new if not valid_format? or not valid_transition?
    
    timer = Time.now
    
      do_convertions
      
    self.spent = Time.now - timer
    
    self.converted = true
    self.save
    self
    
  rescue FormatException => ex
    self.conv_exceptions.build(:message => ex.message)
    self.converted = false
    self.save
    self
  end
  
  def result_filename
    self.asset.full_filename.gsub(/#{self.from}$/, self.to)
  end
  
  private
  def valid_format?
    self.asset.valid_from_format?
  end
  
  def valid_transition?
    converter
  end
  
  def converter
    @converter ||= AssetType.get_converter(self.from, self.to)
    @converter
  end
  
  def do_convertions
    unless converter.is_a?(Array) and converter.size > 1
      conv = converter.new(self.asset.full_filename)
      conv.convert!
    else
      if (conv = Conversion.convert(self.asset, converter[0]) and conv.converted?)
        doc = converter[1].new(conv.result_filename)
        doc.convert!
      else
        raise FormatException.new
      end
    end
  end
  
  def report_long_time
    AdminNotifier.deliver_long_convert(self) if self.spent.to_i > 10
  end
  
end
