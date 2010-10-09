class CreatePartyroles < ActiveRecord::Migration
  def self.up
    create_table :partyroles do |t|
      t.integer :party_id
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :partyroles
  end
end
