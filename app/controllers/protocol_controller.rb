class ProtocolController < ApplicationController
  before_filter :authenticate_user!#if user_signed_in?, current_user.full_name, etc. 
  before_filter :check_access
  
  def syncCollectionCloudtoLocal()    
    params.permit(:collection)    
    collection = params[:collection]
    
    begin
      session = Moped::Session.new([ "127.0.0.1:27017"])
      session.use('e_kbri_production')
      
      table = session[collection]
      table.drop
      
      session.command(
        cloneCollection: 'e_kbri_production.' + collection,
        from: "162.243.144.189:27017"       
      )
      
      if current_user.sync.nil?
        current_user.sync = Sync.new({ :visas_last_synched => Time.now, :passports_last_synched => Time.now})
        current_user.save
      end      
      
      if collection.downcase == 'passports'
        current_user.sync.touch(:passports_last_synched)
      else
        current_user.sync.touch(:visas_last_synched)
      end
      
      msg = { :notice => 'Data Synchronization Success' }
        
    rescue
      
      msg = { :alert => 'Data Synchronization Failed' }
       
    end 
    
    if collection.downcase == 'passports'
      redirect_to '/dashboard/service/passport', msg  
    else
      redirect_to '/dashboard/service/visa', msg
    end    
  end
  
  def syncDBComplete()
    
    begin
      session = Moped::Session.new(["127.0.0.1:27017"])
      session.use('e_kbri_production')
      session.drop
      
      session.use('admin')
      
      session.command(
          copydb: 1,
          fromhost: '162.243.144.189',
          fromdb: 'e_kbri_production',
          todb: 'e_kbri_production',
      )
      
      msg = { :notice => 'Data Synchronization Success' }
      
    rescue
      
      msg = { :alert => 'Data Synchronization Failed' }
      
    end
    
    redirect_to '/dashboard/service/visa', msg
    
  end
  
  protected
  def check_access
    if !current_user.has_role? :admin then
      redirect_to root_path, :flash => { :warning => "The URL you attempt to access is not exist." }
    else  
    end
  end
  
end
