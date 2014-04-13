class Visa
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  

  before_create :set_vipacounter #:assign_visa_fee  #, :assign_visa_type
  belongs_to :user, :class_name => "User", :inverse_of => :visa
  
  

  field :owner_id,               type: String
  field :ref_id,                 type: String
  field :application_type,       type: Integer 
  field :category_type,          type: String
  field :visa_type,              type: Integer, default: 1 #1 = individual, #2 = Family, 3 = Group
  field :reason,                 type: String
  
  field :first_name,					   type: String
  field :last_name,              type: String
  field :sex,						         type: String  
  field :email,						       type: String
  field :placeBirth,				     type: String 
  field :dateBirth, 				     type: Date
  field :marital_status,			   type: String 
  field :nationality,				     type: String 
  field :profession,				     type: String
  field :profession_detail,      type: String
   
  field :passport_no,				     type: String 
  field :passport_issued,			   type: String 
  field :passport_type,				   type: String 
  field :passport_date_issued,	 type: Date 
  field :passport_date_expired,	 type: Date
  
  field :sponsor_type_kr,			   type: String
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

  field :num_entry,					     type: String, default: 'S'
  
  field :checkbox_1,				     type: Boolean, default: false
  field :checkbox_2,				     type: Boolean, default: false
  field :checkbox_3,				     type: Boolean, default: false
  field :checkbox_4,				     type: Boolean, default: false
  field :checkbox_5,				     type: Boolean, default: false
  field :checkbox_6,				     type: Boolean, default: false
  field :checkbox_7,				     type: Boolean, default: false
  
  field :count_dest,             type: String 
  field :flight_vessel,			     type: String 
  field :air_sea_port,			     type: String 
  field :date_entry, 			       type: Date 
  field :purpose,				         type: String
  
  field :status,                 type: String,  default: 'Received'

  field :status_code,            type: Integer, default: 1  


  field :payment_date,           type: Date
  field :vipa_no,                type: Integer
  field :print_code,             type: String
  field :approval_no,            type: String, default: 'N/A'

  field :is_sync,                type: Integer,     default: 0
  field :visafee,                type: Integer

  field :visafee_ref,            type: String
  
  field :comment,                type: String
  field :printed_date,           type: Date
  field :pickup_office,          type: String, default: 'seoul'
  field :pickup_date,            type: Date
  
  validates :pickup_office,         presence: true, :if => :check_paid
  

  validates :application_type,       presence: true 
  validates :category_type,          presence: true, :if => :check_not_reentry
  validates :visa_type,              presence: true, :if => :check_not_reentry
  
  validates :first_name,             presence: true, length: { minimum: 1, maximum: 25 }
  validates :last_name,              presence: true, length: { minimum: 1, maximum: 30 }
  validates :sex,                    presence: true  
  #validates :email,                  presence: true
  validates :placeBirth,             presence: true, length: { minimum: 1, maximum: 30 } 
  validates :dateBirth,              presence: true
  validates :marital_status,         presence: true 
  validates :nationality,            presence: true 
  validates :profession,             presence: true, length: { minimum: 1, maximum: 50 }
   
  validates :passport_no,            presence: true, length: { minimum: 1, maximum: 15 } 
  validates :passport_issued,        presence: true, length: { minimum: 1, maximum: 30 } 
  validates :passport_type,          presence: true 
  validates :passport_date_issued,   presence: true 
  validates :passport_date_expired,  presence: true
  
  validates :sponsor_type_kr,        presence: true, :if => :check_not_reentry
  validates :sponsor_name_kr,        presence: true, :if => :check_not_reentry  
  validates :sponsor_address_kr,     presence: true, :if => :check_not_reentry
  validates :sponsor_address_city_kr,presence: true, :if => :check_not_reentry
  validates :sponsor_address_prov_kr,presence: true, :if => :check_not_reentry
  validates :sponsor_phone_kr,       presence: true, :if => :check_not_reentry
      
  validates :sponsor_type_id,        presence: true
  validates :sponsor_name_id,        presence: true  
  validates :sponsor_address_id,     presence: true
  validates :sponsor_address_kab_id, presence: true
  validates :sponsor_address_prov_id,presence: true
  validates :sponsor_phone_id,       presence: true
    
  validates :duration_stays,         presence: true, numericality: { only_integer: true }, :if => :check_not_reentry
  validates :duration_stays_unit,    presence: true, :if => :check_not_reentry 

  validates :num_entry,              presence: true, :if => :check_not_reentry
  validates :visafee_ref,            presence: true, :if => :check_verified

  validates :air_sea_port,           presence: true
  
  validates :count_dest,             presence: true, :if => :check_transit
  validates :flight_vessel,          presence: true, :if => :check_transit 
  validates :date_entry,             presence: true, :if => :check_transit
  
  validates :approval_no,             presence: true, :if => :check_limited_stay
  
  #validates :checkbox_1,             presence: true
  #validates :checkbox_2,             presence: true
  #validates :checkbox_3,             presence: true
  #validates :checkbox_4,             presence: true
  #validates :checkbox_5,             presence: true
  #validates :checkbox_6,             presence: true
  #validates :checkbox_7,             presence: true  
  
  ##validates :status,                 presence: true
  ##validates :status_code,            presence: true
  ##validates :payment_slip,           presence: true
  ##validates :payment_date,           presence: true
  ##validates :vipa_no,                presence: true
  
  ##validates :approval_no,            presence: true
  
  has_mongoid_attached_file :photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 2.megabytes
  
  has_mongoid_attached_file :idcard, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :idcard, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :idcard
  validates_attachment_size :idcard, less_than: 2.megabytes
  
  has_mongoid_attached_file :passport, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :passport, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :passport
  validates_attachment_size :passport, less_than: 2.megabytes
  
  has_mongoid_attached_file :supdoc
  validates_attachment_content_type :supdoc, :content_type => %w(application/zip application/x-rar-compressed application/octet-stream image/jpeg image/jpg image/png application/pdf)
  validates_attachment_size :supdoc, less_than: 5.megabytes
  
  has_mongoid_attached_file :ticket, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :ticket, :content_type => %w(image/jpeg image/jpg image/png application/pdf)  
  validates_attachment_size :ticket, less_than: 2.megabytes
  

  has_mongoid_attached_file :slip_photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :slip_photo, :content_type => %w(image/jpeg image/jpg image/png application/pdf)  
  validates_attachment_size :slip_photo, less_than: 2.megabytes
  
  private
  def set_vipacounter
    if Visa.all.count > 0
      begin
        cur = Visa.max(:vipa_no)
        if cur > 9999
          self.vipa_no =  1000  
        else
          self.vipa_no =  cur + 1
        end        
      rescue
        self.vipa_no = 1000
      end      
    else
      self.vipa_no = 1000
    end
  end
  def check_verified
    if self.status == 'Verified'
      return true
    else
      return false
    end
  end
  def check_not_reentry
    if self.application_type == 3
      return true
    else
      return false
    end
  end
  def check_transit
    if self.category_type == 'transit'
      return true
    else
      return false
    end
  end
  def check_limited_stay
    if self.category_type == 'limited-stay' or self.category_type == 'multiple' or self.category_type == 'dirjenim'
      return true
    else
      return false
    end
  end
  def check_paid
    if self.status == 'Paid'
      return true
    else
      return false
    end
  end  

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
    self.ref_id = self.ref_id
  end
  
  def assign_visa_fee_ref
    if !self.type_of_visa.nil? and !self.num_entry.nil? then
      visa = Visafee.where(application_of_visa: self.category_type, type_of_visa: self.type_of_visa, num_entry: self.num_entry)
      self.visafee = visa.fee_of_visa
    elsif !self.type_of_visa.nil?
      visa = Visafee.where(application_of_visa: self.category_type, type_of_visa: self.type_of_visa)
      self.visafee = visa.fee_of_visa
    else 
      visa = Visafee.where(application_of_visa: self.category_type)
      self.visafee = visa.fee_of_visa
    end
  end
  
  def assign_visa_fee
    #visit
    if self.category_type == 'visit' then
      if self.num_entry == 'M' then
        self.visafee = 100
      else
        self.visafee = 45
      end 
    #transit  
    elsif self.category_type == 'transit'
      self.visafee = 20
    #limited-stay
    elsif self.category_type == 'limited-stay'
      if self.type_of_visa == '2Y' then
        self.visafee = 175
      elsif self.type_of_visa == '1Y'
        self.visafee = 100
      elsif self.type_of_visa == '6M'
        self.visafee = 50
      elsif self.type_of_visa == '1M'
        self.visafee = 64
      else 
        self.visafee = 0
      end
    #official
    elsif self.category_type == 'official'
      self.visafee = 0
    #diplomatic
    elsif self.category_type == 'diplomatic'
      self.visafee = 0
    #reentry
    elsif self.category_type == 'reentry'
      if self.type_of_visa == 'extension' then
        self.visafee = 22
      elsif type_of_visa == '6M' 
        self.visafee = 64
      elsif type_of_visa == '1Y' 
        self.visafee = 100
      elsif type_of_visa == '2Y'
        self.visafee = 187
      end
    else
      self.visafee = 6 #kawat, visa
    end 
  end
end