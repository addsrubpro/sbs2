class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :description

      t.timestamps
    end
    
    Right.create  :id => 1, :description => "admin"
    Right.create  :id => 2, :description => "people_search_advanced"
    
  end

  def self.down
    drop_table :rights
  end
end
