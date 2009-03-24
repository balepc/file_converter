module AssetsHelper
  
  def format_filename(asset, to_ext)
    asset.filename.gsub(/#{File.extname(asset.filename)}$/, ".#{to_ext}")
  end
  
end
