Gem::Specification.new do |s|
  s.name = 'attacheable'
  s.version = '1.5'
  s.date    = '2009-09-27'
  s.summary = 'Library to handle image uploads'
  s.email   = "max@maxidoors.ru"
  s.author  = "Max Lapshin"
  s.description = "Fork of attachment_fu. It differs in following ways:



  1. Can work with merb uploads

  2. can create thumbnails on fly

  3. goes with Mongrel handler, that autocreate thumbnails on demand

  4. works only with file system (and does it better, than attachment_fu)

  5. create only one row in table for one image. No separate rows for each thumbnail."
  s.rubyforge_project = "attacheable"
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
  s.has_rdoc          = false
  s.files = ["init.rb",
             "attacheable.gemspec",
             "Rakefile",
             "lib/attacheable.rb",
             "lib/attacheable/file_naming.rb",
             "lib/attacheable/photo_handler.rb",
             "lib/attacheable/uploading.rb",
             "test/test_helper.rb",
             "test/attacheable_test.rb",
             "test/fixtures/test.doc",
             "test/fixtures/wrong_type",
             "test/fixtures/test.psd",
             "test/fixtures/test.mov",
             "README",
             "README.ru"
             ]
end

