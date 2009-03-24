class CreateAuthTokens < ActiveRecord::Migration
  def self.up
    create_table :auth_tokens do |t|
      t.integer :asset_id
      t.string :token, :length => 100
      t.timestamp :token_expires
    end
  end

  def self.down
    drop_table :auth_tokens
  end
end