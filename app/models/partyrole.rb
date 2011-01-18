class Partyrole < ActiveRecord::Base
  belongs_to :role
  belongs_to :party
end

# == Schema Information
# Schema version: 20101205122557
#
# Table name: partyroles
#
#  id         :integer         not null, primary key
#  party_id   :integer
#  role_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

