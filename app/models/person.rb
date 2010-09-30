class Person < ActiveRecord::Base
  belongs_to :incomeclassification #, :foreign_key => "incomeclassification_id"
  belongs_to :occupationclassification
end
