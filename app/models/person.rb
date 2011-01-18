class Person < ActiveRecord::Base
  validates_presence_of :current_first_name
  
  belongs_to :incomeclassification , :foreign_key => "incomeclassification_id"  # the foreign key in the people table (active record class: Person) is named incomeclassification_id - this attribut contains the primary key of the incomeclassifications table (active record class: Incomeclassification); The foreign_key is defined always after the "belongs_to" statement.
  belongs_to :occupationclassification , :foreign_key => "occupationclassification_id"
  has_one :user, :foreign_key => "party_id"      # 1 person has 0..1 user -> thus, has_one relationship; user is dependent from person, thus, define the :foreign_key  
  has_one :party

  before_destroy :check_for_user

  private

  def check_for_user    # method to check if an association exists (if a user record exists for the person)
    if !user.nil?
      return false
    end
  end
end