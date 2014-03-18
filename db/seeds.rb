# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



=begin

'Transit Visa' => 'transit', 'Visit Visa' => 'visit', 
                          'Limited Stay Visa' => 'limited-stay', 'Diplomatic Visa' => 'diplomatic', 
                          'Official Visa' => 'official' 
  

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
=end

visa_kunjungan_usaha = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'commercial',
  name_of_visa: 'Visa Kunjungan Usaha',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_kunjungan_usaha.save!

visa_sosial_budaya_art = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'art',
  name_of_visa: 'Visa Sosial Budaya',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_sosial_budaya_art.save!

visa_sosial_budaya_sport = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'sport',
  name_of_visa: 'Visa Sosial Budaya',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_sosial_budaya_sport.save!

visa_wisata = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'tourism',
  name_of_visa: 'Visa Wisata',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_sosial_budaya_sport.save!

visa_kunjungan_dirjenim = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'Visa Kunjungan (Dirjenim)',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_kunjungan_dirjenim.save!

visa_transit = Visafee.new(
  application_of_visa: 'transit',
  type_of_visa: 'transit',
  name_of_visa: 'Visa Transit',
  fee_of_visa: 20, 
  category_of_visa: 'A'
)
visa_transit.save!
