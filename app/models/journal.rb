class Journal #its User action Logs | Differentiated with system Logs
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user, :class_name => "User", :inverse_of => :journal  
  
  field :action,      type: String #Verified, Paid, Reject, Print, etc
  field :model,       type: String #Visa,Passport,Report,etc
  field :method,      type: String #Insert, Delete, Update
  field :agent,       type: String #User Agent : Mozilla/5.0 (Windows; U; Windows NT 6.0; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9
  field :record_id,   type: String #Reference Record Object ID
  field :ref_id,      type: String
  
  validates_presence_of :action, :model, :method, :agent, :record_id
  
end
