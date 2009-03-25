module AssetsHelper
  
  def format_filename(asset, to_ext)
    filename = asset.filename.gsub(/#{File.extname(asset.filename)}$/, ".#{to_ext}")
    format_long_filenames(filename, 40)
  end
  
  def format_long_filenames(long_filename, size)
    raise Exception if size < 10
    return long_filename if size >= long_filename.size
    
    second = long_filename.match(/.\.[a-z0-9]+$/)[0]
    first  = long_filename[0, size - 3 - second.size]
    
    "#{first}...#{second}"
  end
  
end
