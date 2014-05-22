class PlaygroundController < ApplicationController
  #GET /playground
  def index
    if true then
      
      @message = redis.lrange("msgs",-100,-1).reverse
      
      respond_to do |format|
        format.html { }
        format.json { render json:  {action: "JSON Creating playground", result: "Saved"} }
        format.js   
        format.pdf  { render pdf: "<p>This will be a PDF document</p>"}
      end
     
    end
  end
  
  def new
  
  end

  #POST /playground
  def create
  
    if true then
      
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Your playground application is successfully received!" }
        format.json { render json: {action: "JSON Creating playground", result: "Saved"} }
        format.js
        format.pdf  do 
          #"<p>This will be a PDF document</p>"          
        end
      end
     
    end
    
  end
  
  #GET, POST, PATCH, PUT /playground
  def experiment
    #few = 4
    #@db_string = "Experiment in playground is counted #{few} times."
    #@playground = Playground.new(:value => @db_string, :workertime => Time.now)
    #@playground.save!
    #UserMailer.visa_received_email(@visa[0]).deliver
    #NameMailer of name_mailer.method(method params).deliver
    
    RecapWorker.perform_async('bob', 5)
    @message = redis.lrange("msgs",-100,-1).reverse
    
    if true then
      respond_to do |format|
        format.html { }
        format.json { render json: {action: "JSON Creating playground", result: "Saved"} }
        format.js
        format.pdf  do 
         
        end
      end
    end
    
  end

  #GET /playground/:id
  def show
    
  end
  
  #PATCH, PUT /playground/:id
  def update
    
  end
  
  #GET /playground/:id/edit
  def edit
    
  end
  
  #DELETE /playground/:id
  def destroy 
    
  end
  
  def clear
    #redis.del("msgs")
    #redirect_to(:action => :index)
  end

  private
  def redis
    @redis ||= Redis.new
  end
  
  def post_params
      params.require(:playground).permit(:op1, :op2).merge(owner_id: current_user.id, 
      ref_id: 'PG-'+generate_string+"-"+Random.new.rand(10**5..10**6).to_s)
  end

  def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      password = ''
      length.times { |i| password << chars[rand(chars.length)] }
      password = password.upcase
  end
    
end
