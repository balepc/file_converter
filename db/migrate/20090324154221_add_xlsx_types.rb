class AddXlsxTypes < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'xlsx', :mime_type=>'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    AssetType.create(:code => 'xls', :mime_type=>'application/vnd.ms-excel')
    AssetType.create(:code => 'csv', :mime_type=>'text/csv')
    AssetType.create(:code => 'ods', :mime_type=>'application/vnd.oasis.opendocument.spreadsheet')
  end

  def self.down
  end
end
