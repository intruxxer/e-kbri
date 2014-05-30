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
  # Plus: ( VISA.TYPES & PASSPORT.TYPES )
  
  #==== DAILY ====#
  
  field :today_verified_visa_visit,            type: Integer
  field :today_verified_visa_transit,          type: Integer
  field :today_verified_visa_business,         type: Integer
  field :today_verified_visa_business_app,     type: Integer
  field :today_verified_visa_social,           type: Integer
  field :today_verified_visa_social_app,       type: Integer
  field :today_verified_visa_tourist,          type: Integer
  field :today_verified_visa_lim_stay,         type: Integer
  field :today_verified_visa_diplomatic,       type: Integer
  field :today_verified_visa_official,         type: Integer

  field :today_verified_passport_24,            type: Integer
  field :today_verified_passport_48,            type: Integer
  
  field :today_approved_visa_visit,            type: Integer
  field :today_approved_visa_transit,          type: Integer
  field :today_approved_visa_business,         type: Integer
  field :today_approved_visa_business_app,     type: Integer
  field :today_approved_visa_social,           type: Integer
  field :today_approved_visa_social_app,       type: Integer
  field :today_approved_visa_tourist,          type: Integer
  field :today_approved_visa_lim_stay,         type: Integer
  field :today_approved_visa_diplomatic,       type: Integer
  field :today_approved_visa_official,         type: Integer

  field :today_approved_passport_24,            type: Integer
  field :today_approved_passport_48,            type: Integer
  
  field :today_printed_visa_visit,            type: Integer
  field :today_printed_visa_transit,          type: Integer
  field :today_printed_visa_business,         type: Integer
  field :today_printed_visa_business_app,     type: Integer
  field :today_printed_visa_social,           type: Integer
  field :today_printed_visa_social_app,       type: Integer
  field :today_printed_visa_tourist,          type: Integer
  field :today_printed_visa_lim_stay,         type: Integer
  field :today_printed_visa_diplomatic,       type: Integer
  field :today_printed_visa_official,         type: Integer

  field :today_printed_passport_24,            type: Integer
  field :today_printed_passport_48,            type: Integer
  
  field :today_created_visa_visit,            type: Integer
  field :today_created_visa_transit,          type: Integer
  field :today_created_visa_business,         type: Integer
  field :today_created_visa_business_app,     type: Integer
  field :today_created_visa_social,           type: Integer
  field :today_created_visa_social_app,       type: Integer
  field :today_created_visa_tourist,          type: Integer
  field :today_created_visa_lim_stay,         type: Integer
  field :today_created_visa_diplomatic,       type: Integer
  field :today_created_visa_official,         type: Integer

  field :today_created_passport_24,            type: Integer
  field :today_created_passport_48,            type: Integer
  
  field :today_picked_visa_visit,            type: Integer
  field :today_picked_visa_transit,          type: Integer
  field :today_picked_visa_business,         type: Integer
  field :today_picked_visa_business_app,     type: Integer
  field :today_picked_visa_social,           type: Integer
  field :today_picked_visa_social_app,       type: Integer
  field :today_picked_visa_tourist,          type: Integer
  field :today_picked_visa_lim_stay,         type: Integer
  field :today_picked_visa_diplomatic,       type: Integer
  field :today_picked_visa_official,         type: Integer

  field :today_picked_passport_24,            type: Integer
  field :today_picked_passport_48,            type: Integer

  #==== WEEKLY ====#
  
  field :week_verified_visa_visit,            type: Integer
  field :week_verified_visa_transit,          type: Integer
  field :week_verified_visa_business,         type: Integer
  field :week_verified_visa_business_app,     type: Integer
  field :week_verified_visa_social,           type: Integer
  field :week_verified_visa_social_app,       type: Integer
  field :week_verified_visa_tourist,          type: Integer
  field :week_verified_visa_lim_stay,         type: Integer
  field :week_verified_visa_diplomatic,       type: Integer
  field :week_verified_visa_official,         type: Integer

  field :week_verified_passport_24,            type: Integer
  field :week_verified_passport_48,            type: Integer
  
  field :week_approved_visa_visit,            type: Integer
  field :week_approved_visa_transit,          type: Integer
  field :week_approved_visa_business,         type: Integer
  field :week_approved_visa_business_app,     type: Integer
  field :week_approved_visa_social,           type: Integer
  field :week_approved_visa_social_app,       type: Integer
  field :week_approved_visa_tourist,          type: Integer
  field :week_approved_visa_lim_stay,         type: Integer
  field :week_approved_visa_diplomatic,       type: Integer
  field :week_approved_visa_official,         type: Integer

  field :week_approved_passport_24,            type: Integer
  field :week_approved_passport_48,            type: Integer
  
  field :week_printed_visa_visit,            type: Integer
  field :week_printed_visa_transit,          type: Integer
  field :week_printed_visa_business,         type: Integer
  field :week_printed_visa_business_app,     type: Integer
  field :week_printed_visa_social,           type: Integer
  field :week_printed_visa_social_app,       type: Integer
  field :week_printed_visa_tourist,          type: Integer
  field :week_printed_visa_lim_stay,         type: Integer
  field :week_printed_visa_diplomatic,       type: Integer
  field :week_printed_visa_official,         type: Integer

  field :week_printed_passport_24,            type: Integer
  field :week_printed_passport_48,            type: Integer
  
  field :week_created_visa_visit,            type: Integer
  field :week_created_visa_transit,          type: Integer
  field :week_created_visa_business,         type: Integer
  field :week_created_visa_business_app,     type: Integer
  field :week_created_visa_social,           type: Integer
  field :week_created_visa_social_app,       type: Integer
  field :week_created_visa_tourist,          type: Integer
  field :week_created_visa_lim_stay,         type: Integer
  field :week_created_visa_diplomatic,       type: Integer
  field :week_created_visa_official,         type: Integer

  field :week_created_passport_24,            type: Integer
  field :week_created_passport_48,            type: Integer
  
  field :week_picked_visa_visit,            type: Integer
  field :week_picked_visa_transit,          type: Integer
  field :week_picked_visa_business,         type: Integer
  field :week_picked_visa_business_app,     type: Integer
  field :week_picked_visa_social,           type: Integer
  field :week_picked_visa_social_app,       type: Integer
  field :week_picked_visa_tourist,          type: Integer
  field :week_picked_visa_lim_stay,         type: Integer
  field :week_picked_visa_diplomatic,       type: Integer
  field :week_picked_visa_official,         type: Integer

  field :week_picked_passport_24,            type: Integer
  field :week_picked_passport_48,            type: Integer
  
  #==== MONTH ====#
  
  field :month_verified_visa_visit,            type: Integer
  field :month_verified_visa_transit,          type: Integer
  field :month_verified_visa_business,         type: Integer
  field :month_verified_visa_business_app,     type: Integer
  field :month_verified_visa_social,           type: Integer
  field :month_verified_visa_social_app,       type: Integer
  field :month_verified_visa_tourist,          type: Integer
  field :month_verified_visa_lim_stay,         type: Integer
  field :month_verified_visa_diplomatic,       type: Integer
  field :month_verified_visa_official,         type: Integer

  field :month_verified_passport_24,            type: Integer
  field :month_verified_passport_48,            type: Integer
  
  field :month_approved_visa_visit,            type: Integer
  field :month_approved_visa_transit,          type: Integer
  field :month_approved_visa_business,         type: Integer
  field :month_approved_visa_business_app,     type: Integer
  field :month_approved_visa_social,           type: Integer
  field :month_approved_visa_social_app,       type: Integer
  field :month_approved_visa_tourist,          type: Integer
  field :month_approved_visa_lim_stay,         type: Integer
  field :month_approved_visa_diplomatic,       type: Integer
  field :month_approved_visa_official,         type: Integer

  field :month_approved_passport_24,            type: Integer
  field :month_approved_passport_48,            type: Integer
  
  field :month_printed_visa_visit,            type: Integer
  field :month_printed_visa_transit,          type: Integer
  field :month_printed_visa_business,         type: Integer
  field :month_printed_visa_business_app,     type: Integer
  field :month_printed_visa_social,           type: Integer
  field :month_printed_visa_social_app,       type: Integer
  field :month_printed_visa_tourist,          type: Integer
  field :month_printed_visa_lim_stay,         type: Integer
  field :month_printed_visa_diplomatic,       type: Integer
  field :month_printed_visa_official,         type: Integer

  field :month_printed_passport_24,            type: Integer
  field :month_printed_passport_48,            type: Integer
  
  field :month_created_visa_visit,            type: Integer
  field :month_created_visa_transit,          type: Integer
  field :month_created_visa_business,         type: Integer
  field :month_created_visa_business_app,     type: Integer
  field :month_created_visa_social,           type: Integer
  field :month_created_visa_social_app,       type: Integer
  field :month_created_visa_tourist,          type: Integer
  field :month_created_visa_lim_stay,         type: Integer
  field :month_created_visa_diplomatic,       type: Integer
  field :month_created_visa_official,         type: Integer

  field :month_created_passport_24,            type: Integer
  field :month_created_passport_48,            type: Integer
  
  field :month_picked_visa_visit,            type: Integer
  field :month_picked_visa_transit,          type: Integer
  field :month_picked_visa_business,         type: Integer
  field :month_picked_visa_business_app,     type: Integer
  field :month_picked_visa_social,           type: Integer
  field :month_picked_visa_social_app,       type: Integer
  field :month_picked_visa_tourist,          type: Integer
  field :month_picked_visa_lim_stay,         type: Integer
  field :month_picked_visa_diplomatic,       type: Integer
  field :month_picked_visa_official,         type: Integer

  field :month_picked_passport_24,            type: Integer
  field :month_picked_passport_48,            type: Integer
  

end
