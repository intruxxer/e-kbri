class WelcomeController < ApplicationController
  def index	
    @latestvisadata = {}
    @latestreportdata = {}
    @latestpassportdata = {}
  	if user_signed_in?
  	  puts "Cuser=>"+current_user.inspect
  	  visadata = Visa.where(user_id: current_user)
  	  puts "Visa-data=>"+visadata.inspect
  	  passportdata = Passport.where(user_id: current_user)
      puts "Passport-data=>"+visadata.inspect
  		reportdata = Report.where(user_id: current_user)
  		puts "Report-data=>"+reportdata.inspect
  		
  		if visadata.count > 0
  		  puts "Visadata=>1 or more"
        visadata.each do |t|
          @latestvisadata["visaapply" + t.id] = {'status' => 'Success', 'link' => edit_visa_path(current_user), 'name' => 'Visa Application', 'timestamp' => t.updated_at}
        end
      end
  		puts "latestVisadata=>"+@latestvisadata.inspect
  		
  		if passportdata.count > 0
        puts "Passport-data=>1 or more"
        passportdata.each do |t|
          @latestpassportdata["passportapply" + t.id] = {'status' => 'Success', 'link' => edit_passport_path(current_user), 'name' => 'Aplikasi Paspor/SPLP', 'timestamp' => t.updated_at}
        end
      end
      puts "latestPassportdata=>"+@latestpassportdata.inspect
  		
  		if reportdata.count > 0
  			reportdata.each do |t|
  				@latestreportdata["lapordiri" + t.id] = {'status' => 'Success', 'link' => edit_report_path(current_user), 'name' => 'Pelaporan Data Diri', 'timestamp' => t.updated_at}
  			end
  		end
  		
  	end
	
  end
  
  def concept
    #to show the concept
  end
  
end
