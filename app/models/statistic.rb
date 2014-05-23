class Statistic
  include Mongoid::Document
  
  #JOURNAL
  field :today_verified_visa,           type: Integer
  field :today_verified_passport,       type: Integer
  field :today_approved_visa,           type: Integer
  field :today_approved_passport,       type: Integer
  field :today_printed_visa,            type: Integer
  field :today_printed_passport,        type: Integer
  #VISA & #PASSPORT
  field :today_created_visa,            type: Integer
  field :today_created_passport,        type: Integer
  field :today_picked_visa,             type: Integer
  field :today_picked_passport,         type: Integer
  
  #JOURNAL
  field :week_verified_visa,            type: Integer
  field :week_verified_passport,        type: Integer
  field :week_approved_visa,            type: Integer
  field :week_approved_passport,        type: Integer
  field :week_printed_visa,             type: Integer
  field :week_printed_passport,         type: Integer
  #VISA & #PASSPORT
  field :week_created_visa,             type: Integer
  field :week_created_passport,         type: Integer
  field :week_picked_visa,              type: Integer
  field :week_picked_passport,          type: Integer
  
  #JOURNAL
  field :month_verified_visa,           type: Integer
  field :month_verified_passport,       type: Integer
  field :month_approved_visa,           type: Integer
  field :month_approved_passport,       type: Integer
  field :month_printed_visa,            type: Integer
  field :month_printed_passport,        type: Integer
  #VISA & #PASSPORT
  field :month_created_visa,            type: Integer
  field :month_created_passport,        type: Integer
  field :month_picked_visa,             type: Integer
  field :month_picked_passport,         type: Integer
  
  # SPECIFIC STATS BASED ON THEIR OWN TYPES 
  # ( TODAY, WEEK, MONTH ) vs ( VERIFIED, APPROVED, PRINTED, CREATED, PICKED ) 
  # Bonus plus ( VISA.TYPES & PASSPORT.TYPES )
  
  field :today_verified_visa_visit,     type: Integer
  field :today_verified_visa_stay,      type: Integer
  field :today_verified_visa_multiple,  type: Integer
  #another visatype, etc
  
  field :today_verified_passport_24,    type: Integer
  field :today_verified_passport_48,    type: Integer


  
end