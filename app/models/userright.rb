class Userright < ActiveRecord::Base
  belongs_to :user  , :foreign_key => "user_id"      # see footnote:1
  belongs_to :right  , :foreign_key => "right_id"     # see footnote:2
end


# footnote1:
# In this case the definition of the :foreign_key => "party_id" is necessary!!!
# Because, party_id is not the natural id of the Users table (this would be user_id, but this
# would be wrong for that purpose).

# footnote2:
# In this case the manual definition of the foreign_key is obsolete, because
# Rails infers the relevant id automatically. However it is possible to define
# :foreign_key => "right_id" (this is a artificial label: SingularTableName_id)
# If :foreign_key => "right_id" is not explicitely defined, 
# Rails would infer the "right_id" (SingularTableName_+_id)

# foreign_key's contain the values of the same key name from the related table.
# So, both tables are connected by the same value between key <---> foreign_key