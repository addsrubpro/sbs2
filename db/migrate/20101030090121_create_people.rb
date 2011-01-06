class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :party_id
      t.integer :incomeclassification_id
      t.integer :occupationclassification_id
      t.string :current_last_name
      t.string :current_first_name
      t.date :birth_date

      t.timestamps
    end
    
    Person.create :party_id => 1,
                  :current_last_name => "Administrator",
                  :birth_date => "1000-01-01"
    
  end

  def self.down
    drop_table :people
  end
end
