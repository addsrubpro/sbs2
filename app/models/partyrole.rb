class Partyrole < ActiveRecord::Base
  belongs_to :role
  belongs_to :party
end
