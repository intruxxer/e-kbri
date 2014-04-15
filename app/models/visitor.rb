class Visitor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  
  field :who,           type: String
  field :action,        type: String
  field :ip_address,    type: String
  field :coordinates,   type: Array
  field :address,       type: String
  #Geocode needs this field to store the geo info in geocode data
  #Geocode stores geocode info in coordinates[0] as latitude, coordinates[1] as longitude)
  
  geocoded_by :ip_address, :latitude => :lat, :longitude => :lon
  after_validation :geocode
  
  reverse_geocoded_by :coordinates
  after_validation :reverse_geocode
  
end
