class Visitor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  
  field :ip_address,    type: String
  field :action,        type: String
  field :latitude,      type: Float
  field :longitude,     type: Float
  field :coordinates,   type: Array
  
  geocoded_by :ip_address, :latitude => :lat, :longitude => :lon
  after_validation :geocode
  
end
