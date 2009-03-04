class ConversionLogger < Logger
    
  def initialize()
    super(File.open(File.join(RAILS_ROOT, "log/conversion.log"), 'a'))
  end
    
  def format_message(severity, timestamp, progname, msg)
    "| #{timestamp.to_formatted_s(:db)} | #{severity} | #{msg}\n" 
  end
    
end
