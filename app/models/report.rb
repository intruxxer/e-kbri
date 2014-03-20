class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  before_create :assign_ref_id
  belongs_to :user, :class_name => "User", :inverse_of => :report
  
  field :owner_id,                  type: String
  field :ref_id,                    type: String  
  field :name,                      type: String
  validates :name,    presence: true
  field :height,                    type: String
  validates :height,  presence: true
  field :birthplace,                type: String
  validates :birthplace,  presence: true
  field :datebirth,                 type: Date
  validates :datebirth,   presence: true
  field :marriagestatus,            type: String
  validates :marriagestatus,  presence: true
  
  field :nopaspor,                  type: String
  validates :nopaspor,      presence: true
  field :dateissued,                type: Date
  validates :dateissued,    presence: true
  field :dateend,                   type: Date
  validates :dateend,       presence: true
  field :passportplace,             type: String
  validates :passportplace, presence: true  
  field :immigrationOffice,         type: String
  validates :immigrationOffice,   presence: true
  
  field :visatype,                  type: String
  validates :visatype,      presence: true
  field :visadateissued,            type:Date
  validates :visadateissued, presence: true 
  field :visadateend,               type:Date 
  validates :visadateend, presence: true
  
  field :jobStudyInKorea,        type: String
  validates :jobStudyInKorea, presence: true
  field :jobStudyTypeInKorea,    type: String
  validates :jobStudyTypeInKorea, presence: true
  field :jobStudyOrganization,   type: String
  validates :jobStudyOrganization, presence: true
  field :jobStudyAddress,        type: String
  validates :jobStudyAddress,   presence: true
  
  field :koreanphone,               type:String
  validates :koreanphone,   presence: true
  field :koreanaddress,             type:String
  validates :koreanaddress, presence: true
  field :koreanaddresscity,         type:String
  validates :koreanaddresscity, presence: true
  field :koreanaddressprovince,     type:String
  validates :koreanaddressprovince, presence: true
  field :koreanaddresspostalcode,   type:String
  validates :koreanaddresspostalcode, presence: true
  
  field :indonesianphone,             type:String
  validates :indonesianphone, presence: true
  field :indonesianaddress,           type:String
  validates :indonesianaddress, presence: true
  field :indonesianaddresskelurahan,  type:String
  validates :indonesianaddresskelurahan, presence: true
  field :indonesianaddresskecamatan,  type:String
  validates :indonesianaddresskecamatan, presence: true
  field :indonesianaddresskabupaten,  type:String
  validates :indonesianaddresskabupaten, presence: true
  field :indonesianaddressprovince,   type:String
  validates :indonesianaddressprovince, presence: true
  field :indonesianaddresspostalcode, type:String
  validates :indonesianaddresspostalcode, presence: true
  
  field :relationname,              type:String
  validates :relationname,  presence: true
  field :relationstatus,            type:String
  validates :relationstatus, presence: true
  field :relationphone,             type:String
  validates :relationphone,   presence: true
  field :relationaddress,           type:String
  validates :relationaddress, presence: true
  field :relationaddresskelurahan,  type:String
  validates :relationaddresskelurahan, presence: true
  field :relationaddresskecamatan,  type:String
  validates :relationaddresskecamatan, presence: true
  field :relationaddresskabupaten,  type:String
  validates :relationaddresskabupaten, presence: true
  field :relationaddressprovince,   type:String
  validates :relationaddressprovince, presence: true
  field :relationaddresspostalcode, type:String
  validates :relationaddresspostalcode, presence: true
  
  field :arrivaldate,               type:Date
  field :indonesianinstance,        type:String
   
  field :stayinkorea,               type:Boolean, default: true  
  
  
  has_mongoid_attached_file :photo, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 2.megabytes
  
  has_mongoid_attached_file :aliencard, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :aliencard, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :aliencard
  validates_attachment_size :aliencard, less_than: 2.megabytes
  
  has_mongoid_attached_file :paspor, :styles => { :thumb => "90x120>" }
  validates_attachment_content_type :paspor, :content_type => %w(image/jpeg image/jpg image/png)
  validates_attachment_presence :paspor
  validates_attachment_size :paspor, less_than: 2.megabytes
  
  private
  def assign_ref_id
    self.ref_id = Time.new.year.to_s + "/KONS/" + generate_string(3)
  end
  def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      random_characters = ''
      length.times { |i| random_characters << chars[rand(chars.length)] }
      random_characters = random_characters.upcase
  end
end
