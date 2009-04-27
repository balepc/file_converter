class CreateFormats < ActiveRecord::Migration
  def self.up
    create_table :formats do |t|
      t.string :code
      
      t.string :title
      t.string :description
      t.string :keywords
      
      t.string :text, :length => 1024
    end
    
    Format.create(:code => 'docx', :title => 'Docx to doc converter', :description => 'Online free docx to doc converter', :keywords => 'docx, doc, docx to doc, docx convert doc, converter, convert, instantly, change docx to doc, online, free, ms office, office xp, office 2007, office 2003, docx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>docx</b> to <b>doc</b>, <b>odt</b>, <b>txt</b>, <b>pdf</b> and other formats.')
    Format.create(:code => 'doc', :title => 'Doc to docx converter', :description => 'Online free doc to docx converter', :keywords => 'docx, doc, doc to docx, doc convert docx, pdf, converter, convert, instantly, change doc to docx, online, free, ms office, office xp, office 2007, office 2003, docx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>doc</b> to <b>docx</b>, <b>odt</b>, <b>txt</b>, <b>pdf</b> and other formats.')

    Format.create(:code => 'pptx', :title => 'Pptx converter', :description => 'Online pptx to ppt converter', :keywords => 'pptx, ppt, pptx to ppt, pptx convert ppt, pdf, converter, convert, instantly, change pptx to ppt, online, free, ms office, office xp, office 2007, office 2003, pptx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>pptx</b> to <b>ppt</b>, <b>pdf</b>, <b>odp</b> formats.')
    Format.create(:code => 'ppt', :title => 'Ppt converter', :description => 'Online ppt to pptx converter', :keywords => 'pptx, ppt, ppt to pptx, ppt convert pptx, pdf, converter, convert, instantly, change ppt to pptx, online, free, ms office, office xp, office 2007, office 2003, pptx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>ppt</b> to <b>pptx</b>, <b>pdf</b>, <b>odp</b> formats.')
    
    Format.create(:code => 'xls', :title => 'xls converter', :description => 'Online xls to xlsx converter', :keywords => 'xlsx, xls, xls to xlsx, xls convert xlsx, pdf, converter, convert, instantly, change xls to xlsx, online, free, ms office, office xp, office 2007, office 2003, xlsx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>xls</b> to <b>xlsx</b> and <b>ods</b> formats.')
    Format.create(:code => 'xlsx', :title => 'xlsx converter', :description => 'Online xls to xlsx converter', :keywords => 'xlsx, xls, xlsx to xls, xlsx convert xls, pdf, converter, convert, instantly, change xlsx to xls, online, free, ms office, office xp, office 2007, office 2003, xlsx 2003, old version, open office, windows, openoffice', :text => 'Web-service for simple conversion from <b>xlsx</b> to <b>xls</b>, <b>pdf</b>, <b>odp</b> and <b>csv</b> formats.')
  end

  def self.down
    drop_table :formats
  end
end
