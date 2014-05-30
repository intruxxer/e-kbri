# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stat_default = Statistic.new(
  today_created_visa: 0,
  today_created_passport: 0, 
  today_verified_visa: 0,
  today_verified_passport: 0,
  today_approved_visa: 0,
  today_approved_passport: 0, 
  today_printed_visa: 0,
  today_printed_passport: 0,
  today_picked_visa: 0,
  today_picked_passport: 0,
  
  week_created_visa: 0,
  week_created_passport: 0, 
  week_verified_visa: 0,
  week_verified_passport: 0,
  week_approved_visa: 0,
  week_approved_passport: 0, 
  week_printed_visa: 0,
  week_printed_passport: 0,
  week_picked_visa: 0,
  week_picked_passport: 0,
  
  month_created_visa: 0,
  month_created_passport: 0,
  month_verified_visa: 0,
  month_verified_passport: 0,
  month_approved_visa: 0,
  month_approved_passport: 0, 
  month_printed_visa: 0,
  month_printed_passport: 0,
  month_picked_visa: 0,
  month_picked_passport: 0
  
  #later, based on their type - Visa.types && Passport.types PER day, PER week, PER month!
  
)
stat_default.save!