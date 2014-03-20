# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

passport_48halaman = Passportfee.new(
  passport_type: 'passport_48',
  passport_fee: 22,
  passport_category: 'IAI'
)
passport_48halaman.save!

passport_48halaman_hilang = Passportfee.new(
  passport_type: 'passport_48',
  passport_fee: 43,
  passport_category: 'IAI',
  passport_reason: 'hilang'
)
passport_48halaman_hilang.save!

passport_24halaman = Passportfee.new(
  passport_type: 'passport_24',
  passport_fee: 6,
  passport_category: 'IAI'
)
passport_24halaman.save!

passport_24halaman_hilang = Passportfee.new(
  passport_type: 'passport_24',
  passport_fee: 11,
  passport_category: 'IAI',
  passport_reason: 'hilang'
)
passport_24halaman_hilang.save!

splp = Passportfee.new(
  passport_type: 'splp',
  passport_fee: 5,
  passport_category: 'ICI'
)
splp.save!