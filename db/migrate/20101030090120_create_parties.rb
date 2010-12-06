class CreateParties < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|

      t.timestamps
    end
    
    Party.create :id => 1
    
  end

  def self.down
    drop_table :parties
  end
end
