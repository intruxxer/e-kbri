class Site
  include Mongoid::Document

  field :name

  has_many :users, inverse_of: :site, order: :email.desc

  validates :name, presence: true, uniqueness: true
end