class Right < ActiveRecord::Base
  has_many :userrights , :foreign_key => "right_id", :dependent => :delete_all  # if a right record is deleted the related records in the userrights table will be deleted too
  has_many :users, :through => :userrights           # pay attention to the PLURAL in :userrights (in the case of has_many)!
end

# == Schema Information
# Schema version: 20101205122557
#
# Table name: rights
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

