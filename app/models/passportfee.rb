class Passportfee
  include Mongoid::Document
  
  field :passport_type,      type: String
  field :passport_fee,       type: Integer
  field :passport_category,  type: Integer
end