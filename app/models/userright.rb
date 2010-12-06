class Userright < ActiveRecord::Base
  belongs_to :user
  belongs_to :right #, :foreign_key => "right_id"
end
