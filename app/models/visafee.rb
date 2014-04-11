class Visafee
  include Mongoid::Document
  
  field :application_of_visa,type: String #visit
  field :type_of_visa,       type: String #commercial
  field :name_of_visa,       type: String
  field :fee_of_visa,        type: Integer
  field :category_of_visa,   type: String
  field :num_entry,          type: String

end