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
    subject "converter.tds.lv - Cannot convert"
    
    body :filename => filename
  end
  
  def long_convert(conversion)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - Long conversion time"
    
    body :filename => conversion.asset.filename, :time => conversion.spent
  end
  
  def ip_blocked(blocked_ip)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - IP blocked"
    
    body :ip_address => blocked_ip.ip_address
  end
  
  def conv_request(conv_request, url)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - New conversion request"
    
    body :url => url, :email => conv_request.email
  end

end
