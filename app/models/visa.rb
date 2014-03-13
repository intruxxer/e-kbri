class Visa
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  field :owner_id,               type: String
  field :ref_id,                 type: String
  field :application_type,       type: Integer 
  field :category_type,          type: String
  field :visa_type,              type: Integer #1 = individual, #2 = Family, 3 = Group
  
  field :first_name,					   type: String
  field :last_name,              type: String
  field :sex,						         type: String  
  field :email,						       type: String
  field :placeBirth,				     type: String 
  field :dateBirth, 				     type: Date
  field :marital_status,			   type: String 
  field :nationality,				     type: String 
  field :profession,				     type: String
  field :address_kr,             type: String
  field :address_city_kr,        type: String
  field :address_prov_kr,        type: String
   
  field :passport_no,				     type: String 
  field :passport_issued,			   type: String 
  field :passport_type,				   type: String 
  field :passport_date_issued,	 type: Date 
  field :passport_date_expired,	 type: Date
  
  field :sponsor_type_kr,			   type: Integer
  field :sponsor_name_kr,			   type: String  
  field :sponsor_address_kr,		 type: String
  field :sponsor_address_city_kr,type: String
  field :sponsor_address_prov_kr,type: String
  field :sponsor_phone_kr,			 type: String
    	
  field :sponsor_type_id,			   type: Integer
  field :sponsor_name_id,			   type: String  
  field :sponsor_address_id,		 type: String
  field :sponsor_address_kab_id, type: String
  field :sponsor_address_prov_id,type: String
  field :sponsor_phone_id,			 type: String
    
  field :duration_stays,		     type: Integer
  field :duration_stays_unit,	   type: String 

  field :num_entry,					     type: String
  
  field :checkbox_1,				     type: Boolean, default: false
  field :checkbox_2,				     type: Boolean, default: false
  field :checkbox_3,				     type: Boolean, default: false
  field :checkbox_4,				     type: Boolean, default: false
  field :checkbox_5,				     type: Boolean, default: false
  field :checkbox_6,				     type: Boolean, default: false
  field :checkbox_7,				     type: Boolean, default: false
  
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
  field :ticketpath,             type: String
  field :sup_docpath,            type: String
  
  field :status,                 type: String, default: 'Received'
  field :status_code,            type: Integer,default: 1
  field :payment_slip,           type: String
  field :payment_date,           type: Date
  field :vipa_no,                type: Integer
  
  field :approval_no,            type: String, default: 'N/A'
  
  belongs_to :user, :class_name => "User", :inverse_of => :visa

  field :is_sync,                type: Integer,     default: 0
  
  #validates :owner_id,               presence: true
  #validates :ref_id,                 presence: true
  validates :application_type,       presence: true 
  validates :category_type,          presence: true
  validates :visa_type,              presence: true
  
  validates :first_name,             presence: true
  validates :last_name,              presence: true
  validates :sex,                    presence: true  
  #validates :email,                  presence: true
  validates :placeBirth,             presence: true 
  validates :dateBirth,              presence: true
  validates :marital_status,         presence: true 
  validates :nationality,            presence: true 
  validates :profession,             presence: true
  #validates :address_kr,             presence: true
  #validates :address_city_kr,        presence: true
  #validates :address_prov_kr,        presence: true
   
  validates :passport_no,            presence: true 
  validates :passport_issued,        presence: true 
  validates :passport_type,          presence: true 
  validates :passport_date_issued,   presence: true 
  validates :passport_date_expired,  presence: true
  
  #validates :sponsor_type_kr,        presence: true
  #validates :sponsor_name_kr,        presence: true  
  #validates :sponsor_address_kr,     presence: true
  #validates :sponsor_address_city_kr,presence: true
  #validates :sponsor_address_prov_kr,presence: true
  #validates :sponsor_phone_kr,       presence: true
      
  #validates :sponsor_type_id,        presence: true
  #validates :sponsor_name_id,        presence: true  
  #validates :sponsor_address_id,     presence: true
  #validates :sponsor_address_kab_id, presence: true
  #validates :sponsor_address_prov_id,presence: true
  #validates :sponsor_phone_id,       presence: true
    
  validates :duration_stays,         presence: true
  validates :duration_stays_unit,    presence: true 

  validates :num_entry,              presence: true
  
  #validates :checkbox_1,             presence: true
  #validates :checkbox_2,             presence: true
  #validates :checkbox_3,             presence: true
  #validates :checkbox_4,             presence: true
  #validates :checkbox_5,             presence: true
  #validates :checkbox_6,             presence: true
  #validates :checkbox_7,             presence: true
  
  #validates :passportpath,           presence: true
  #validates :idcardpath,             presence: true 
  validates :photopath,              presence: true
  #validates :ticketpath,             presence: true
  #validates :sup_docpath,            presence: true
  
  #validates :status,                 presence: true
  #validates :status_code,            presence: true
  #validates :payment_slip,           presence: true
  #validates :payment_date,           presence: true
  #validates :vipa_no,                presence: true
  
  #validates :approval_no,            presence: true
  
  has_mongoid_attached_file :photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 2.megabytes
  
  private
  def assign_ref_id
    self.ref_id = generate_string(3)+"-"+Random.new.rand(10**4..10**10).to_s
  end
  def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      random_characters = ''
      length.times { |i| random_characters << chars[rand(chars.length)] }
      random_characters = random_characters.upcase
  end
  def assign_visa_type
    self.ref_id = 'KBRI'+ self.visa_type.to_s + '-' + self.ref_id
  end
end