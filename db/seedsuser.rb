# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
  email: 'admin@kbri.seoul.kr',
  first_name: 'Admin', 
  last_name: 'e-KBRI Seoul',
  passport: 'ADM1234',
  id_card: '850917-1234567',
  citizenship: true, 
  roles: ['admin'], 
  password: 'admin2014ekbri',
  password_confirmation: 'admin2014ekbri'
)
admin.skip_confirmation!
admin.save!

user = User.new(
  email: 'ali.fahmi.pn@gmail.com',
  first_name: 'Ali Fahmi Perwira', 
  last_name: 'Negara', 
  passport: 'ADM1234',
  id_card: '850917-1234567',
  citizenship: true,
  roles: ['user'], 
  password: '12345678',
  password_confirmation: '12345678'
)
user.skip_confirmation!
user.save!

moderator = User.new(
  email: 'permatarizki@gmail.com',
  first_name: 'Permata Nur', 
  last_name: 'Miftahurizki',
  passport: 'ADM1234',
  id_card: '850917-1234567',
  citizenship: true, 
  roles: ['moderator'], 
  password: '12345678',
  password_confirmation: '12345678'
)
moderator.skip_confirmation!
moderator.save!