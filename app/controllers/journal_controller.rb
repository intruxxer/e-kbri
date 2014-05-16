class JournalController < ApplicationController
  
  def retrieve_user_journal 
    userid = params[:user_id]
    
    @journal = User.find(userid).journals.desc(:created_at)       
    origin = @journal
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @journal = @journal.any_of({:model => /#{searchparam}/},{:action => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @journal = @journal.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = origin.count
    iTotalDisplayRecords = @journal.count
    aaData = Array.new    
    i = 1
    @journal.each do |row|      
      aaData.push([i,  row.action, row.model, row.method, row.created_at.strftime("%Y %b %d %H:%M:%S").to_s, row.record_id ])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  def retrieve_document_journal 
    recordid = params[:id]
    
    @journal = Journal.desc(:created_at).where(:record_id => recordid)     
    origin = @journal
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @journal = @journal.any_of({:model => /#{searchparam}/},{:action => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @journal = @journal.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = origin.count
    iTotalDisplayRecords = @journal.count
    aaData = Array.new    
    
    i = 1
    @journal.desc(:created_at)
    @journal.each do |row|      
      respected_user = User.where(:id => row.user_id)
      if respected_user.count > 0
        respected_user = respected_user.first.first_name + ' ' + respected_user.first.last_name
      else
        respected_user = "Deleted User"
      end
      action = row.action + ' by ' + respected_user
      aaData.push([i, action, row.method, row.created_at.strftime("%Y %b %d %H:%M:%S").to_s ])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  def show_all_journal
    @journal = Journal.desc(:created_at)   
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)        
    
    @journal = @journal.all    
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @journal = @journal.any_of({:full_name => /#{searchparam}/},{:ref_id => /#{searchparam}/},{:status => /#{searchparam}/},{:pickup_office => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @journal = @journal.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = Journal.count
    iTotalDisplayRecords = @journal.count
    aaData = Array.new    
    
    
    
    @journal.each do |journ|     
      
      if journ.model == "Visa" || journ.model == "Passport" || journ.model == "Report"
        ls = journ.record_id
        unless journ.ref_id.nil?
          ls = journ.ref_id
        end
        link = "<a target=\"_blank\" href=\"/" + journ.model.downcase + "s/check/" + journ.record_id + "\">" + ls +  "</a>"  
      else
        link = " - "
      end
      
      aaData.push([ journ.action, journ.user_id, journ.model, journ.method, journ.created_at.strftime("%-d %b %Y"), link ])
              
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
end
