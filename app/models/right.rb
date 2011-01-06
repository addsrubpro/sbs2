class Right < ActiveRecord::Base
  has_many :userrights , :foreign_key => "right_id", :dependent => :delete_all  # if a right record is deleted the related records in the userrights table will be deleted too
  has_many :users, :through => :userrights           # pay attention to the PLURAL in :userrights (in the case of has_many)!
end
