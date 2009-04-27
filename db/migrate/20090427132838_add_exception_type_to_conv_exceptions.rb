class AddExceptionTypeToConvExceptions < ActiveRecord::Migration
  def self.up
    add_column :conv_exceptions, :exception_type, :string
  end

  def self.down
    remove_column :conv_exceptions, :exception_type
  end
end
