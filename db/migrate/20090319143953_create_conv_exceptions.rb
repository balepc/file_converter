class CreateConvExceptions < ActiveRecord::Migration
  def self.up
    create_table :conv_exceptions do |t|
      t.integer :conversion_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :conv_exceptions
  end
end
