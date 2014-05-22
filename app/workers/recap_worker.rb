class RecapWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :top_priority

  def perform(name, count)
    #mongoDB Job
    @db_string = name.titleize + " is counted #{count} times."
    @playground = Playground.new(:value => @db_string, :workertime => Time.now)
    @playground.save!
    #current_user.playgrounds.push(Playground.new())
    
    #Redis Job
    n = 1
    count.times {
      hellowork "#{n},Doing hard work, #{name}"
      puts hellowork
      redis.rpush "msgs", hellowork
      n += 1
    }
  end
  
  def calculate_verified_visa
    #@num_verified_visa_today = Journal.where(action: 'Verified', model: 'Visa', created_at)
  end
  
  def redis
    @redis ||= Redis.new
  end
  
end