class Person < ActiveRecord::Base
  belongs_to :incomeclassification , :foreign_key => "incomeclassification_id"  # the foreign key in the people table (active record class: Person) is named incomeclassification_id - this attribut contains the primary key of the incomeclassifications table (active record class: Incomeclassification); The foreign_key is defined always after the "belongs_to" statement.
  belongs_to :occupationclassification , :foreign_key => "occupationclassification_id"
  has_one :user, :foreign_key => "party_id"      # 1 person has 0..1 user -> thus, has_one relationship; user is dependent from person, thus, define the :foreign_key  
  has_one :party
end
