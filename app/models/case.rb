class Case
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  belongs_to :user, :class_name => "User", :inverse_of => :passport

  field :status,                      type: String, default: "Diterima"
  field :full_name,                   type: String
  field :gender,                      type: String
  field :place_birth,                 type: String
  field :date_birth,                  type: Date, default: Date.today
  field :passport_no,                 type: String
  field :passport_place,              type: String
  field :passport_date_from,          type: Date, default: Date.today
  field :passport_date_to,            type: Date, default: Date.today
  
  field :address_id,                  type: String
  field :kelurahan_id,                type: String
  field :kecamatan_id,                type: String
  field :kabupaten_id,                type: String
  field :provinsi_id,                 type: String
  field :phone_id,                    type: String
  
  field :visa_kr,                     type: String
  field :visa_kr_type,                type: String
  field :visa_kr_from,                type: Date, default: Date.today
  field :visa_kr_to,                  type: Date, default: Date.today
  field :address_kr,                  type: String
  field :city_kr,                     type: String
  field :province_kr,                 type: String
  field :phone_kr,                    type: String
  
  field :company_kr,                  type: String
  field :company_address_kr,          type: String
  field :company_city_kr,             type: String
  field :company_province_kr,         type: String
  field :company_phone_kr,            type: String
  
  field :case_type,                   type: String
  field :case_description,            type: String
  field :case_embassy_on_assistance,  type: String
  field :case_embassy_post_assistance,type: String
  field :case_embassy_staff_name,     type: String
  field :case_remarks,                type: String     
  
  has_mongoid_attached_file :case_embassy_supporting_doc
  validates_attachment_content_type :case_embassy_supporting_doc, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  #validates_attachment_presence :case_embassy_supporting_doc
  validates_attachment_size :case_embassy_supporting_doc, less_than: 5.megabytes 
  
  has_mongoid_attached_file :case_embassy_supporting_photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :case_embassy_supporting_photo, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  #validates_attachment_presence :case_embassy_supporting_doc2
  validates_attachment_size :case_embassy_supporting_photo, less_than: 5.megabytes  
  
  has_mongoid_attached_file :case_user_supporting_doc, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :case_user_supporting_doc, :content_type => %w(application/octet-stream application/zip application/x-rar-compressed image/jpeg image/jpg image/png application/pdf application/x-pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)
  #validates_attachment_presence :case_user_supporting_doc
  validates_attachment_size :case_user_supporting_doc, less_than: 2.megabytes     

end

