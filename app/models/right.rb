class Right < ActiveRecord::Base
  has_many :userrights , :foreign_key => "party_id"
  has_many :users, :through => :userrights           # pay attention to the PLURAL in :userrights (in the case of has_many)!
end
