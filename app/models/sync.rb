class Sync
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user, :class_name => "User", :inverse_of => :sync
  
  field :passports_last_synched, type: DateTime
  field :visas_last_synched,     type: DateTime
  
  
  
end
