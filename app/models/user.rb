class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include User::AuthDefinitions
  include User::Roles

  has_many :identities
  has_many :visas, :class_name => 'Visa'
  has_one :report, :class_name => "Report", :inverse_of => :user
  #has_one :profile
  


  field :email, type: String
  field :image, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :passport, type: String
  field :id_card, type: String
  field :citizenship, type: Boolean, default: true

  field :roles_mask, type: Integer
  
  validates_presence_of :email, :first_name, :last_name

  
  
  def full_name
    "#{first_name} #{last_name}"
  end

end
