class AssetType < ActiveRecord::Base
  
  validates_presence_of :mime_type
  validates_presence_of :code
  
  def converts?(to)
    return false unless to
    return true if (self.docx?) and (to.pdf? or to.odt? or to.txt? or to.doc? or to.rtf?)
  end
  
  ['docx', 'doc', 'pdf', 'txt', 'odt', 'rtf'].each do |format|
    define_method("#{format}?") { self.code == format }
  end

end
