class Playground
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :workertime, type: DateTime
  field :value,   type: String
  
end