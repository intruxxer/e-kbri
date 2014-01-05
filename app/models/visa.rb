class Visa
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user, :class_name => "User", :inverse_of => :visa
  
  field :full_name,					     type: String
  field :sex,						         type: String  
  field :email,						       type: String
  field :picture_path,				   type: String
  field :placeBirth,				     type: String 
  field :dateBirth, 				     type: Date
  field :marital_status,			   type: String 
  field :nationality,				     type: String 
  field :profession,				     type: String
   
  field :passport_no,				     type: String 
  field :passport_issued,			   type: String 
  field :passport_type,				   type: String 
  field :passport_date_issued,	 type: Date 
  field :passport_date_expired,	 type: Date
  
  field :sponsor_type_kr,			   type: String
  field :sponsor_name_kr,			   type: String  
  field :sponsor_address_kr,		 type: String
  field :sponsor_phone_kr,			 type: String  	
  field :sponsor_type_id,			   type: String
  field :sponsor_name_id,			   type: String  
  field :sponsor_address_id,		 type: String
  field :sponsor_phone_id,			 type: String
    
  field :duration_stays_day,		 type: Integer
  field :duration_stays_month,	 type: Integer
  field :duration_stays_year,		 type: Integer 
  field :num_entry,					     type: Integer
    
  field :application_type,			 type: Integer 
  field :category_type,				   type: Integer
  
  field :checkbox_1,				     type: Boolean 
  field :checkbox_2,				     type: Boolean
  field :checkbox_3,				     type: Boolean
  field :checkbox_4,				     type: Boolean
  field :checkbox_5,				     type: Boolean
  field :checkbox_6,				     type: Boolean
  field :checkbox_7,				     type: Boolean
  
  field :tr_count_dest,          type: String 
  field :tr_flight_vessel,			 type: String 
  field :tr_air_sea_port,			   type: String 
  field :tr_date_entry, 			   type: Date 
  
  field :lim_s_purpose,				   type: String 
  field :lim_s_flight_vessel,		 type: String 
  field :lim_s_air_sea_port,		 type: String 
  field :lim_s_date_entry, 			 type: Date
  
  field :v_purpose,					     type: String 
  field :v_flight_vessel,			   type: String 
  field :v_air_sea_port,			   type: String 
  field :v_date_entry, 				   type: Date
  
  field :dip_purpose,				     type: String 
  field :dip_flight_vessel,			 type: String 
  field :dip_air_sea_port,			 type: String 
  field :dip_date_entry, 			   type: Date
  
  field :o_purpose,					     type: String 
  field :o_flight_vessel,			   type: String 
  field :o_air_sea_port,			   type: String 
  field :o_date_entry, 				   type: Date
  
  field :passportpath,           type: String
  field :idcardpath,             type: String 
  field :photopath,              type: String
  
end