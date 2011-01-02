class Person < ActiveRecord::Base
  belongs_to :incomeclassification , :foreign_key => "incomeclassification_id"  # the foreign key in the people table (active record class: Person) is named incomeclassification_id - this attribut contains the primary key of the incomeclassifications table (active record class: Incomeclassification); The foreign_key is defined always after the "belongs_to" statement.
  belongs_to :occupationclassification , :foreign_key => "occupationclassification_id"
  belongs_to :user , :foreign_key => "party_id"
  has_one :party
end
