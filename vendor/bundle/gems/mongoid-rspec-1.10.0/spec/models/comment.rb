class Comment
  include Mongoid::Document

  embedded_in :article, inverse_of: :comments, polymorphic: true
  belongs_to :user, inverse_of: :comments
end