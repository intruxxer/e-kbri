class Visa
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user_id, type: String
  field :family_ref_id, type: String
  field :group_ref_id, type: String
end