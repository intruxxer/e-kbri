class Reference
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :consulat_name,     type: String
  field :consulat_name_two, type: String
  field :treasurer_name,    type: String
  field :embassy_location,  type: String
  field :title_name,        type: String
  field :title_name_two,    type: String
  
  
end
