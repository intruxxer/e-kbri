class Passport
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :owner_id,               type: String
  field :ref_id,                 type: String
  field :application_type,       type: String 
  field :application_reason,     type: String
  
  field :full_name,              type: String
  field :height,                 type: String
   
  field :placeBirth,             type: String 
  field :dateBirth,              type: Date
  field :marriage_status,        type: Integer
  
  field :lastPassportNo,         type: String
  field :dateIssued,             type: Date
  field :placeIssued,            type: String
  
  field :jobStudyInKorea,        type: String
  field :jobStudyOrganization,   type: String
  field :jobStudyAddress,        type: String
  field :phoneKorea,             type: String
  field :addressKorea,           type: String 
  field :phoneIndonesia,         type: String
  field :addressIndonesia,       type: String
  field :dateArrival,            type: Date
  field :sendingParty,           type: Integer
  
  field :photopath,              type: String

  field :status,                 type: String, default: 'Received'
  field :payment_slip,           type: String
  field :payment_date,           type: Date
  
  belongs_to :user, :class_name => "User", :inverse_of => :passport
end