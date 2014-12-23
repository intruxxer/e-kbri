class Passport
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip  
  
  before_create :assign_ref_id, :assign_passport_fee, :set_vipacounter, :set_capitalized
  after_update :assign_passport_fee
  belongs_to :user, :class_name => "User", :inverse_of => :passport
  
  field :owner_id,               type: String
  field :ref_id,                 type: String
  field :application_type,       type: String
  field :application_reason,     type: String
  field :paspor_type,            type: String, default: 24

  
  field :full_name,              type: String
  field :kelamin,                type: String
  field :height,                 type: Integer
  field :arc,                    type: String
   
  field :placeBirth,             type: String 
  field :dateBirth,              type: Date
  field :citizenship_status,     type: String
  
  field :lastPassportNo,         type: String
  field :dateIssued,             type: Date, default: Date.today
  field :placeIssued,            type: String
  field :dateIssuedEnd,          type: String, default: Date.today
  field :immigrationOffice,      type: String, default: 'Imigrasi'
  
  field :jobStudyInKorea,        type: String
  field :jobStudyTypeInKorea,    type: String
  field :jobStudyOrganization,   type: String
  field :jobStudyAddress,        type: String
  
  field :phoneKorea,             type: String
  field :addressKorea,           type: String
  field :cityKorea,              type: String
  field :sponsor_address_prov_kr,type: String
   
  field :phoneIndonesia,         type: String
  field :addressIndonesia,       type: String
  field :kelurahanIndonesia,     type: String
  field :kabupatenIndonesia,     type: String
  field :kecamatanIndonesia,     type: String
  field :sponsor_address_prov_id,type: String
  
  field :dateArrival,            type: Date
  field :sendingParty,           type: Integer
  
  field :status,                 type: String, default: 'Received'
  field :status_code,            type: Integer

  field :payment_date,           type: Date
  
  field :passport_no,            type: String
  field :reg_no,                 type: String
  field :lapordiri_no,           type: String
  
  field :passportfee,           type: Integer, default: 6

  field :vipacounter,           type: Integer
  field :comment,               type: String
  
  field :printed_date,          type: Date
  field :pickup_office,         type: String, default: 'seoul'
  field :pickup_date,           type: Date

  
  validates :application_type,   presence: true
  validates :application_reason, presence: true
  validates :paspor_type,        presence: true
  validates :full_name,          presence: true, length: { minimum: 1, maximum: 32 }
  validates :kelamin,            presence: true
  validates :placeBirth,         presence: true, length: { minimum: 1, maximum: 30 }
  validates :dateBirth,          presence: true
  validates :citizenship_status, presence: true
  

  validates :lastPassportNo,     presence: true, length: { minimum: 1, maximum: 32 }, :if => :check_application_reason
  validates :placeIssued,        presence: true, length: { minimum: 1, maximum: 30 }, :if => :check_application_reason
  validates :dateIssued,         presence: true, :if => :check_application_reason
  validates :dateIssuedEnd,      presence: true, :if => :check_application_reason
  #validates :immigrationOffice,  presence: true, :if => :check_application_reason

  
  validates :jobStudyInKorea,    presence: true, length: { minimum: 1, maximum: 50 }
  validates :jobStudyTypeInKorea, presence: true
  validates :jobStudyOrganization, length: { minimum: 1, maximum: 50 }
  validates :jobStudyAddress,    length: { minimum: 1, maximum: 50 }
  
  validates :phoneKorea,         presence: true, length: { minimum: 1, maximum: 30 }
  validates :addressKorea,       presence: true #, length: { minimum: 1, maximum: 100 } #maximum of 100 characters for SPRI
  validates :cityKorea,          presence: true
  
  validates :phoneIndonesia,     presence: true, length: { minimum: 1, maximum: 30 }
  validates :addressIndonesia,   presence: true #, length: { minimum: 1, maximum: 50 } #maximum of 50 characters for SPRI
  validates :kelurahanIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  validates :kabupatenIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  validates :kecamatanIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  

  validates :payment_date, presence: true, :if => :check_paid
  validates :pickup_office, presence: true, :if => :check_paid  
  validates :pickup_date, presence: true, :if => :check_approved
  has_mongoid_attached_file :photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 2.megabytes
  
  has_mongoid_attached_file :slip_photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :slip_photo, :content_type => %w(image/jpeg image/jpg image/png application/pdf application/x-pdf)
  validates_attachment_size :slip_photo, less_than: 2.megabytes
  validates_attachment_presence :slip_photo, :if => :check_paid

  
  has_mongoid_attached_file :supporting_doc
  validates_attachment_content_type :supporting_doc, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  validates_attachment_size :supporting_doc, less_than: 2.megabytes
  
  has_mongoid_attached_file :supporting_doc_2
  validates_attachment_content_type :supporting_doc_2, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  validates_attachment_size :supporting_doc_2, less_than: 2.megabytes
  
  has_mongoid_attached_file :supporting_doc_3
  validates_attachment_content_type :supporting_doc_3, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  validates_attachment_size :supporting_doc_3, less_than: 2.megabytes
  
  has_mongoid_attached_file :supporting_doc_4
  validates_attachment_content_type :supporting_doc_4, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  validates_attachment_size :supporting_doc_4, less_than: 2.megabytes
  
  
  
  private

  def set_vipacounter
    if Passport.all.count > 0
      #capacity : 9000 applications per day
      #7000 Normal capacity
      #1000 offset capcity
      begin
        todayis = Date.new(Date.today.year, Date.today.month, 1) 
        cur = Passport.all.where(:created_at => { '$gte' => todayis } ).max(:vipacounter) 
        if cur == nil
          self.vipacounter = 3000
        elsif cur >= 9999
          cur = Passport.all.where(:created_at => { '$gte' => todayis } ).where(:vipa_no => { '$lt' => 3000 } ).max(:vipacounter)
            if cur == nil
              self.vipacounter = 1000
            else
              self.vipacounter = cur + 1
            end
        else
          self.vipacounter = cur + 1  
        end        
      rescue
        self.vipacounter = 3000
      end      
    else
      self.vipacounter = 3000
    end
  end
  
  def check_paid
    if self.status == 'Paid'
      return true
    end
  end
  
  def check_application_reason
    if self.application_reason == 'lainnya'
      return false
    else
      return true

    end     
  end
  
  def check_approved
    if self.status == 'Approved'
      return true
    else
      return false
    end
  end
  
  def assign_ref_id
    time = Time.new
    coded_date = time.strftime("%y%m%d")
    self.ref_id = 'D'+coded_date+generate_string(3)
  end
  
  def set_capitalized
    self.full_name.upcase
  end
  
  def generate_string(length=5)

      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      random_characters = ''
      length.times { |i| random_characters << chars[rand(chars.length)] }
      random_characters = random_characters.upcase

  end
  
  def assign_passport_fee
    type = "passport_" + self.paspor_type

    if self.application_reason == 'hilang'
      passport = Passportfee.where(passport_type: type, passport_reason: self.application_reason).first
      self.passportfee = passport.passport_fee
    else
      passport = Passportfee.where(passport_type: type, passport_reason: 'regular' ).first      

      self.passportfee = passport.passport_fee
    end
    
  end
  
end