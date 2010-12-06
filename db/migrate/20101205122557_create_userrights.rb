class CreateUserrights < ActiveRecord::Migration
  def self.up
    create_table :userrights do |t|
      t.integer :party_id
      t.integer :right_id

      t.timestamps
    end
    
    Userright.create :party_id => 1,
                     :right_id => 1
    
  end

  def self.down
    drop_table :userrights
  end
end
