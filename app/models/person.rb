class Person < ActiveRecord::Base
  belongs_to :incomeclassification #, :foreign_key => "incomeclassification_id"
  belongs_to :occupationclassification
  belongs_to :user
  has_one :party
end
