class Party < ActiveRecord::Base
  has_many :partyroles
  has_one :person
end
