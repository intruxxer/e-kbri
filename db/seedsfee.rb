# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


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

visa_sosial_budaya_dirjenim = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'sosial budaya',
  name_of_visa: 'Visa Sosial Budaya (Dirjenim)',
  fee_of_visa: 45, 
  category_of_visa: 'B'
)
visa_sosial_budaya_dirjenim.save!

visa_sosial_budaya_free = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'sosial budaya free',
  name_of_visa: 'Visa Sosial Budaya (Bebas Bea)',
  fee_of_visa: 0, 
  category_of_visa: 'B'
)
visa_sosial_budaya_free.save!

visa_sosial_budaya_sport = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'sport',
  name_of_visa: 'Visa Sosial Budaya',
  fee_of_visa: 45, 
  category_of_visa: 'B',
  num_entry: 'S'
)
visa_sosial_budaya_sport.save!

visa_wisata = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'tourism',
  name_of_visa: 'Visa Wisata',
  fee_of_visa: 45, 
  category_of_visa: 'B',
  num_entry: 'S'
)
visa_sosial_budaya_sport.save!

visa_kunjungan_dirjenim = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'dirjenim',
  name_of_visa: 'Visa Kunjungan (Dirjenim)',
  fee_of_visa: 45, 
  category_of_visa: 'B',
  num_entry: 'S'
)
visa_kunjungan_dirjenim.save!

visa_transit = Visafee.new(
  application_of_visa: 'transit',
  type_of_visa: 'transit',
  name_of_visa: 'Visa Transit',
  fee_of_visa: 20, 
  category_of_visa: 'A',
  num_entry: 'S'
)
visa_transit.save!

visa_kunjungan_multiple_dirjenim = Visafee.new(
  application_of_visa: 'visit',
  type_of_visa: 'dirjenim',
  name_of_visa: 'Visa Kunjungan Multiple (Dirjenim)',
  fee_of_visa: 100, 
  category_of_visa: 'D',
  num_entry: 'M'
)
visa_kunjungan_multiple_dirjenim.save!

visa_tinggal_terbatas_2tahun = Visafee.new(
  application_of_visa: 'limited-stay',
  type_of_visa: '2Y',
  name_of_visa: 'Visa Tinggal Terbatas (2 Tahun)',
  fee_of_visa: 175, 
  category_of_visa: 'C',
  num_entry: 'M'
)
visa_tinggal_terbatas_2tahun.save!

visa_tinggal_terbatas_1tahun = Visafee.new(
  application_of_visa: 'limited-stay',
  type_of_visa: '1Y',
  name_of_visa: 'Visa Tinggal Terbatas (1 Tahun)',
  fee_of_visa: 100, 
  category_of_visa: 'C',
  num_entry: 'M'
)
visa_tinggal_terbatas_1tahun.save!

visa_tinggal_terbatas_6bulan = Visafee.new(
  application_of_visa: 'limited-stay',
  type_of_visa: '6M',
  name_of_visa: 'Visa Tinggal Terbatas (6 Bulan)',
  fee_of_visa: 50, 
  category_of_visa: 'C',
  num_entry: 'M'
)
visa_tinggal_terbatas_6bulan.save!

visa_tinggal_terbatas_1bulan = Visafee.new(
  application_of_visa: 'limited-stay',
  type_of_visa: '1M',
  name_of_visa: 'Visa Tinggal Terbatas (1 Bulan/30 Hari)',
  fee_of_visa: 64, 
  category_of_visa: 'C',
  num_entry: 'M'
)
visa_tinggal_terbatas_1bulan.save!

visa_tinggal_terbatas_free = Visafee.new(
  application_of_visa: 'limited-stay',
  type_of_visa: 'FOC',
  name_of_visa: 'Visa Tinggal Terbatas (Free)',
  fee_of_visa: 0, 
  category_of_visa: 'C',
  num_entry: 'M'
)
visa_tinggal_terbatas_free.save!

visa_dinas_single = Visafee.new(
  application_of_visa: 'official',
  type_of_visa: 'dinas',
  name_of_visa: 'Visa Dinas',
  fee_of_visa: 0,
  num_entry: 'S'
)
visa_dinas_single.save!

visa_dinas_multiple = Visafee.new(
  application_of_visa: 'official',
  type_of_visa: 'dinas',
  name_of_visa: 'Visa Dinas',
  fee_of_visa: 0,
  num_entry: 'M'
)
visa_dinas_multiple.save!

visa_diplomat_single = Visafee.new(
  application_of_visa: 'diplomatic',
  type_of_visa: 'diplomat',
  name_of_visa: 'Visa Diplomat',
  fee_of_visa: 0,
  num_entry: 'S'
)
visa_diplomat_single.save!

visa_diplomat_multiple = Visafee.new(
  application_of_visa: 'diplomatic',
  type_of_visa: 'diplomat',
  name_of_visa: 'Visa Diplomat',
  fee_of_visa: 0,
  num_entry: 'M'
)
visa_diplomat_multiple.save!

reentry_permit_extension = Visafee.new(
  application_of_visa: 'reentry',
  type_of_visa: 'extension',
  name_of_visa: 'Re-entry Permit Extension',
  fee_of_visa: 22,
  num_entry: 'S'
)
reentry_permit_extension.save!

reentry_permit_6bulan = Visafee.new(
  application_of_visa: 'reentry',
  type_of_visa: '6M',
  name_of_visa: 'Re-entry Permit 6 Bulan',
  fee_of_visa: 64, 
  num_entry: 'S'
)
reentry_permit_6bulan.save!

reentry_permit_1tahun = Visafee.new(
  application_of_visa: 'reentry',
  type_of_visa: '1Y',
  name_of_visa: 'Re-entry Permit 1 Tahun',
  fee_of_visa: 100, 
  num_entry: 'S'
)
reentry_permit_1tahun.save!

reentry_permit_2tahun = Visafee.new(
  application_of_visa: 'reentry',
  type_of_visa: '2Y',
  name_of_visa: 'Re-entry Permit 2 Tahun',
  fee_of_visa: 187,
  num_entry: 'S'
)
reentry_permit_2tahun.save!

biaya_kawat_ijinvisa = Visafee.new(
  application_of_visa: 'kawat',
  type_of_visa: 'visa',
  name_of_visa: 'Biaya Kawat Ijin Visa',
  fee_of_visa: 6
)
biaya_kawat_ijinvisa.save!