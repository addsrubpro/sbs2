class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :party_id
      t.string :username
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
    
    User.create :id => 1,
                :party_id => 1,
                :username => "admin",
                :password => "start",
                :password_confirmation => "start"
    
  end

  def self.down
    drop_table :users
  end
end
