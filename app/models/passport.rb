class Passport
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  belongs_to :user, :class_name => "User", :inverse_of => :passport
  
  field :owner_id,               type: String
  field :ref_id,                 type: String
  field :application_type,       type: String
  field :application_reason,     type: String
  field :paspor_type,            type: String
  
  field :full_name,              type: String
  field :kelamin,                type: String
  field :height,                 type: Integer
  field :arc,                    type: String
   
  field :placeBirth,             type: String 
  field :dateBirth,              type: Date
  field :citizenship_status,     type: String
  
  field :lastPassportNo,         type: String
  field :dateIssued,             type: Date
  field :placeIssued,            type: String
  field :dateIssuedEnd,          type: String
  field :immigrationOffice,      type: String
  
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
  field :payment_slip,           type: String
  field :payment_date,           type: Date
  
  field :passport_no,            type: String
  field :reg_no,                 type: String
  field :lapordiri_no,           type: String
  
  
  validates :application_type,   presence: true
  validates :application_reason, presence: true
  validates :paspor_type,        presence: true
  validates :full_name,          presence: true, length: { minimum: 1, maximum: 32 }
  validates :kelamin,            presence: true
  validates :placeBirth,         presence: true, length: { minimum: 1, maximum: 30 }
  validates :dateBirth,          presence: true
  validates :citizenship_status, presence: true
  
  validates :lastPassportNo,     presence: true, length: { minimum: 0, maximum: 32 }, :if => :check_application_type
  validates :placeIssued,        presence: true, length: { minimum: 0, maximum: 30 }, :if => :check_application_type
  validates :dateIssued,         presence: true, :if => :check_application_type
  validates :dateIssuedEnd,      presence: true, :if => :check_application_type
  validates :immigrationOffice,  presence: true, :if => :check_application_type
  
  validates :jobStudyInKorea,    presence: true, length: { minimum: 1, maximum: 50 }
  validates :jobStudyTypeInKorea,presence: true
  validates :jobStudyOrganization,length: { minimum: 0, maximum: 50 }
  validates :jobStudyAddress,    length: { minimum: 0, maximum: 50 }
  
  validates :phoneKorea,         presence: true, length: { minimum: 1, maximum: 30 }
  validates :addressKorea,       presence: true, length: { minimum: 1, maximum: 100 }
  validates :cityKorea,          presence: true
  
  validates :phoneIndonesia,     presence: true, length: { minimum: 1, maximum: 30 }
  validates :addressIndonesia,   presence: true, length: { minimum: 1, maximum: 50 }
  validates :kelurahanIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  validates :kabupatenIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  validates :kecamatanIndonesia, presence: true, length: { minimum: 1, maximum: 30 }
  
  has_mongoid_attached_file :photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 2.megabytes
  
  has_mongoid_attached_file :slip_photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :slip_photo, :content_type => %w(image/jpeg image/jpg image/png application/pdf application/x-pdf)
  validates_attachment_size :slip_photo, less_than: 2.megabytes
  
  has_mongoid_attached_file :supporting_doc
  validates_attachment_content_type :supporting_doc, :content_type => %w(application/zip application/x-rar-compressed application/octet-stream)
  validates_attachment_size :supporting_doc, less_than: 5.megabytes
  
  def check_application_type
    if self.application_type == 'perpanjang-paspor'
      return true
    else
      return false
    end     
  end
  
end