class AdminNotifier < ActionMailer::Base

  def wrong_format(filename)
    recipients 'balepc@gmail.com'
    from  "noreply@converter.tds.lv"
    subject "converter.tds.lv - Incorrect format"
    
    body :filename => filename
  end

end
