class Profile
  include Mongoid::Document
  
  belongs_to :user
  
  field :name,		type: String 
  field :email,		type: String 
  
end