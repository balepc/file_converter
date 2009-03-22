module AssetsHelper
  
  def doc_filename(asset)
    replace_extension(asset, '.doc')
  end
  
  def pdf_filename(asset)
    replace_extension(asset, '.pdf')
  end
  
  def odt_filename(asset)
    replace_extension(asset, '.odt')
  end
  
  def txt_filename(asset)
    replace_extension(asset, '.txt')
  end
  
  private
  def replace_extension(asset, to_ext)
    asset.filename.gsub(File.extname(asset.filename), to_ext)
  end
  
end
