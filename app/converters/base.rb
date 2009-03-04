require 'format_exception'

class Base
  
  attr_accessor :master_filename
  
  def initialize(filename)
    self.master_filename = filename
  end
  
  def convert!
    puts "CONV: from #{master_filename} to #{child_filename}"
    command
    
    # retry
    command unless File.exists?(child_filename)
    
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
  
  
end