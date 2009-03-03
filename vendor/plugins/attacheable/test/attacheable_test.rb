require File.dirname(__FILE__)+'/test_helper'
require 'mime/types'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

def setup_db
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Schema.define(:version => 1) do
    create_table :images do |t|
      t.string :something
      t.string :filename
      t.string :content_type
      #t.integer :width
      #t.integer :height
      t.string :type
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Image < ActiveRecord::Base
  has_attachment :thumbnails => {:medium => "120x", :large => "800x600", :preview => "100x100"},
    :croppable_thumbnails => %w(preview)
  validates_as_attachment :message => "Please upload an image file."
  
  def callback_called
    @callback_called
  end
  
  def after_create_thumbnail(thumbnail, thumbnail_path)
    @callback_called = true
    FileUtils.cp(thumbnail_path, thumbnail_path+".backup") if File.exists?(thumbnail_path)
  end
  
end

class Video < Image
  has_attachment :thumbnails => {:raw => "", :preview => "100x100"},
    :croppable_thumbnails => %w(preview), :valid_filetypes => :all, :autocreate => true
  validates_as_attachment :message => "Please upload a video file."
  attr_accessor :width, :height
end

class Photo < Image
end

module TestUploadExtension
  attr_accessor :content_type
  def original_filename
    File.basename(path)
  end
  
  def size
    File.stat(path).size
  end
end

class AttacheableTest < Test::Unit::TestCase
  def setup
    setup_db
  end
  
  def teardown
    teardown_db
    FileUtils.rm_rf(File.dirname(__FILE__)+"/public")
    Image.attachment_options[:autocreate] = false
    Image.attachment_options[:valid_filetypes] = %w(jpeg gif png psd)
  end
  
  def test_image_autoconf
    assert_equal "public/system/images", Image.attachment_options[:path_prefix], "Should guess path prefix right"
  end
  
  def test_image_creation
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    assert_equal "life.jpg", input.original_filename, "should look like uploaded file"
    image = Image.new(:uploaded_data => input)
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    assert image.save!, "Image should be saved"
    assert_equal "life", image.attachment_basename
    assert_equal ".jpg", image.attachment_extname
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be generated"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_image_creation_from_flash
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    input.content_type = "application/octet-stream"
    assert_equal "life.jpg", input.original_filename, "should look like uploaded file"
    image = Image.new(:uploaded_data => input)
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    assert image.save!, "Image should be saved"
    assert_equal "life", image.attachment_basename
    assert_equal ".jpg", image.attachment_extname
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be generated"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_merb_image_creation
    path = File.dirname(__FILE__)+"/fixtures/life.jpg"
    input = {"size"=>File.size(path), "tempfile"=>File.open(path), "filename"=>"life.jpg"}
    image = Image.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    assert_equal "life", image.attachment_basename
    assert_equal ".jpg", image.attachment_extname
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be generated"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_file_renaming
    Image.attachment_options[:autocreate] = true
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    assert_equal "life.jpg", input.original_filename, "should look like uploaded file"
    image = Image.new(:uploaded_data => input)
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    assert image.save!, "Image should be saved"
    assert_equal "life", image.attachment_basename
    assert_equal ".jpg", image.attachment_extname
    assert_equal "/system/images/0000/0001/life_medium.jpg", image.public_filename(:medium)
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should be generated on demand"
    
    image = Image.find(1)
    image.filename = "nonlife.jpg"
    image.save!
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "Old filename should not be kept"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails on renaming should be destroyd"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/nonlife.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/nonlife_medium.jpg"), "Thumbnails on renaming should not be autocreated"
    
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  
  def test_image_with_autocreation
    Image.attachment_options[:autocreate] = true
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    image = Image.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be generated"
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    image.public_filename(:medium)
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should be generated on demand"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end

  def test_autocrop_image
    Image.attachment_options[:autocreate] = true
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    image = Image.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    image.public_filename(:preview)
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_preview.jpg"), "Thumbnails should be generated on demand"
    identify = `identify "#{File.dirname(__FILE__)+"/public/system/images/0000/0001/life_preview.jpg"}"`
    assert Regexp.new(" JPEG 100x100 ").match(identify), "Image should be cropped to format"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_image_with_wrong_type
   input = File.open(File.dirname(__FILE__)+"/fixtures/wrong_type")
   input.extend(TestUploadExtension)
   image = Image.new(:uploaded_data => input)
   assert !image.save, "Image should not be saved"
   assert image.errors.on(:uploaded_data).size > 0, "Uploaded data is of wrong type"
   assert_equal "Please upload an image file.", image.errors.on(:uploaded_data), "Validation message is the one used with :message"
  end

  def test_with_sti
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    image = Photo.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be uploaded as for Image"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_save_raw_binary
    Image.attachment_options[:valid_filetypes] = :all
    input = File.open(File.dirname(__FILE__)+"/fixtures/wrong_type")
    input.extend(TestUploadExtension)
    image = Image.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/wrong_type"), "File should be uploaded"
    #assert !image.send(:full_filename_with_creation, :preview)
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_save_msword
    Image.attachment_options[:valid_filetypes] = :all
    input = File.open(File.dirname(__FILE__)+"/fixtures/test.doc")
    input.extend(TestUploadExtension)
    input.content_type = "application/ms-word"
    image = Image.new(:uploaded_data => input)
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/test.doc"), "File should be uploaded"
    #assert !image.send(:full_filename_with_creation, :preview)
    assert_equal "/system/images/0000/0001/test.doc", image.public_filename
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_create_thumbnail
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    assert_equal "life.jpg", input.original_filename, "should look like uploaded file"
    image = Image.new(:uploaded_data => input)
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be autogenerated"
    photo, data = Image.data_by_path_info(%w(0000 0001 life_medium.jpg))
    assert photo, "Image should be guessed"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should be generated on demand"
    assert data, "New file should be generated"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_after_create_thumbnail
    input = File.open(File.dirname(__FILE__)+"/fixtures/life.jpg")
    input.extend(TestUploadExtension)
    assert_equal "life.jpg", input.original_filename, "should look like uploaded file"
    image = Image.new(:uploaded_data => input)
    assert_equal "life_medium.jpg", image.send(:thumbnail_name_for, :medium), "should generate right thumbnail filename"
    assert image.save!, "Image should be saved"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life.jpg"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should not be autogenerated"
    photo, data = Image.data_by_path_info(%w(0000 0001 life_medium.jpg))
    assert photo, "Image should be guessed"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg"), "Thumbnails should be generated on demand"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/life_medium.jpg.backup"), "After callback should be called"
    assert data, "New file should be generated"
    image.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
  def test_save_from_web
    image = Image.new(:source_url => "http://ya.ru/logo.gif")
    assert image.save, "Image should be saved with http source"
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/logo.gif"), "file should be saved"
  end
  
  def test_nil_upload
    image = Image.new(:uploaded_data => nil)
    assert image.save, "Image should be saved with empty file"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000"), "nothing should be created"
    assert image.update_attributes(:something => "empty"), "should be updateable"
    assert image.destroy, "should be destroyable"
  end

  def test_string_upload
    image = Image.new(:uploaded_data => "life.jpg")
    assert image.save, "Image should be saved with empty file"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000"), "nothing should be created"
    assert image.destroy, "should be destroyable"
  end
  
  def test_mime_type_detection
    input = File.open(File.dirname(__FILE__)+"/fixtures/test.mov")
    input.extend(TestUploadExtension)
    input.content_type = "application/octet-stream"
    assert_equal "test.mov", input.original_filename, "should look like uploaded file"
    video = Video.new(:uploaded_data => input)
    assert video.save!, "Video should be saved"
    assert_equal "video/quicktime", video.content_type
  end
  
  def test_create_video_thumbnail
    input = File.open(File.dirname(__FILE__)+"/fixtures/test.mov")
    input.extend(TestUploadExtension)
    input.content_type = "video/quicktime"
    assert_equal "test.mov", input.original_filename, "should look like uploaded file"
    video = Video.new(:uploaded_data => input)
    assert_equal "test_raw.jpg", video.send(:thumbnail_name_for, :raw), "should generate right thumbnail filename"
    assert video.save!, "Video should be saved"
    assert_equal "video/quicktime", video.content_type
    assert_equal 384, video.width
    assert_equal 288, video.height
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/test.mov"), "File should be saved"
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/test_raw.jpg"), "Thumbnails should not be autogenerated"
    assert_equal "/system/images/0000/0001/test_raw.jpg", video.public_filename(:raw)
    assert File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001/test_raw.jpg"), "Thumbnails should be generated on demand"
    video.destroy
    assert !File.exists?(File.dirname(__FILE__)+"/public/system/images/0000/0001"), "Directory should be cleaned"
  end
  
end