class Incomeclassification < ActiveRecord::Base
  has_many :people
end

# == Schema Information
# Schema version: 20101205122557
#
# Table name: incomeclassifications
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

