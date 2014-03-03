class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include User::AuthDefinitions
  include User::Roles

  has_many :identities, :class_name => "Identity", :inverse_of => :user
  has_many :visas, :class_name => "Visa", :inverse_of => :user
  has_many :passports, :class_name => "Passport", :inverse_of => :user
  has_one :reports
  #has_one :passport
  #has_one :profile
  


  field :email,           type: String
  field :image,           type: String
  field :first_name,      type: String
  field :last_name,       type: String
  field :passport,        type: String
  field :id_card,         type: String
  field :citizenship,     type: Boolean, default: true
  field :origin,          type: String, default: "Indonesia"
  field :individual,      type: Boolean, default: true

  field :roles_mask,    type: Integer, default: 7 #user (7), moderator (4), and admin (1)
  
  validates_presence_of :email, :first_name, :last_name

  
  
  def full_name
    "#{first_name} #{last_name}"
  end

end
