class CreateIncomeclassifications < ActiveRecord::Migration
  def self.up
    create_table :incomeclassifications do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :incomeclassifications
  end
end
