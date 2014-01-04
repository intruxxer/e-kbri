class WelcomeController < ApplicationController
  def index	
    @latestvisadata = {}
    @latestreportdata = {}
  	if user_signed_in?
  	  
  	  visadata = Visa.where(user_id: current_user)
  	  puts "Visadata=>"+visadata.inspect
  		reportdata = Report.where(user_id: current_user)
  		
  		if visadata.count > 0
        visadata.each do |t|
          @latestvisadata["visaapply" + t.id] = {'status' => 'success', 'link' => edit_visa_path(current_user), 'name' => 'Visa Application', 'timestamp' => t.updated_at}
        end
      end
  		
  		if reportdata.count > 0
  			reportdata.each do |t|
  				@latestreportdata["lapordiri" + t.id] = {'status' => 'success', 'link' => edit_report_path(current_user), 'name' => 'Pelaporan Data Diri', 'timestamp' => t.updated_at}
  			end
  		end
  		
  	end
	
  end
  
  def concept
    #to show the concept
  end
  
end
