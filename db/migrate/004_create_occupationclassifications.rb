class CreateOccupationclassifications < ActiveRecord::Migration
  def self.up
    create_table :occupationclassifications do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :occupationclassifications
  end
end
