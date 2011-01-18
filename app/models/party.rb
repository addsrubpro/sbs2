class Party < ActiveRecord::Base
  has_many :partyroles
  has_one :person
end

# == Schema Information
# Schema version: 20101205122557
#
# Table name: parties
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

