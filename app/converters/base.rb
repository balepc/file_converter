require 'format_exception'
require 'conversion_logger'

class Base
  
  attr_accessor :master_filename
  @@logger = ConversionLogger.new
  
  def initialize(filename)
    self.master_filename = filename
  end
  
  def convert!
    Base.logger.warn("CONV: from #{master_filename} to #{child_filename}")
    
    Base.logger.warn(command)
    
    # retry
    unless File.exists?(child_filename)
      sleep(1)
      command 
    end
    
    raise FormatException.new("from #{self.from} to #{self.to}") unless File.exists?(child_filename)
  end
  
  def child_filename
    self.master_filename.gsub(self.from, self.to)
  end
  
  def destroy_master
    FileUtils.rm(self.master_filename)
  end
  
  def destroy_child
    FileUtils.rm(self.child_filename)
  end
  
  def self.logger
    @@logger
  end
  
end