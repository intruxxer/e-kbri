class Passport
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user, :class_name => "User", :inverse_of => :visas
  
end