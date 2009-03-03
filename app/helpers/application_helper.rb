# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def custom_file_field(name)
    "<input type='file' name='#{name}' class='field file' />"
  end
  
end
