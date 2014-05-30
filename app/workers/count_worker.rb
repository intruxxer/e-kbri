class CountWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :top_priority

  def perform(name, count)

  end

  # === x.days.ago is from gem "activesupport" === #
  # === gem "chronic" is also possible if we want === #

  # === TODAY === #

  def calculate_verified_today
    visa = Journal.where(action: 'Verified', model: 'Visa', :created_at => Date.today).order_by(:created_at.desc)
    passport = Journal.where(action: 'Verified', model: 'Passport', :created_at => Date.today).order_by(:created_at.desc)
  end

  def calculate_approved_today
    visa = Journal.where(action: 'Approved', model: 'Visa', :created_at => Date.today).order_by(:created_at.desc)
    passport = Journal.where(action: 'Approved', model: 'Passport', :created_at => Date.today).order_by(:created_at.desc)
  end

  def calculate_printed_today
    visa = Journal.where(action: 'Printed', model: 'Visa', :created_at => Date.today).order_by(:created_at.desc)
    passport = Journal.where(action: 'Printed', model: 'Passport', :created_at => Date.today).order_by(:created_at.desc)
  end

  # === WEEK === #

  def calculate_verified_week
    visa = Journal.where(action: 'Verified', model: 'Visa', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Verified', model: 'Passport', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
  end

  def calculate_approved_week
    visa = Journal.where(action: 'Approved', model: 'Visa', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Approved', model: 'Passport', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
  end

  def calculate_printed_week
    visa = Journal.where(action: 'Printed', model: 'Visa', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Printed', model: 'Passport', :created_at.gte => 7.days.ago).order_by(:created_at.desc)
  end

  # === MONTH === #

  def calculate_verified_month
    visa = Journal.where(action: 'Verified', model: 'Visa', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Verified', model: 'Passport', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
  end

  def calculate_approved_month
    visa = Journal.where(action: 'Approved', model: 'Visa', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Approved', model: 'Passport', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
  end

  def calculate_printed_month
    visa = Journal.where(action: 'Printed', model: 'Visa', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
    passport = Journal.where(action: 'Printed', model: 'Passport', :created_at.gte => 1.month.ago).order_by(:created_at.desc)
  end

  # === end of file === #
  def redis
    @redis ||= Redis.new
  end

end
