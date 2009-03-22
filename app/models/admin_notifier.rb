class AdminNotifier < ActionMailer::Base

  def wrong_format(filename)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - Incorrect format"
    
    body :filename => filename
  end
  
  def cant_convert(filename)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - Incorrect format"
    
    body :filename => filename
  end
  
  def long_convert(conversion)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - Long conversion time"
    
    body :filename => conversion.asset.filename, :time => conversion.spent
  end

end
