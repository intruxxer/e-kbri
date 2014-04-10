class Visagrouppayment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
    
   
  field :payment_date,           type: Date
  field :ref_id,                 type: String  
  field :pickup_office,          type: String
    
  validates :payment_date, presence: true
  validates :ref_id,       presence: true
  
  
  has_mongoid_attached_file :slip_photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :slip_photo, :content_type => %w(image/jpeg image/jpg image/png application/pdf)  
  validates_attachment_size :slip_photo, less_than: 2.megabytes
  validates_attachment_presence :slip_photo
  
  
end