class Person < ActiveRecord::Base
  belongs_to :incomeclassification #, :foreign_key => "incomeclassification_id"
  belongs_to :occupationclassification
  has_one :user , :foreign_key => "party_id"
  has_one :party
end
