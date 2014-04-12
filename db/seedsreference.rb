# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ref = Reference.new(
  consulat_name: 'Didik Eko Pujianto',
  treasurer_name: 'Damayanti',
  embassy_location: 'Seoul',
  title_name: 'Counsellor'  
)

ref.save!
