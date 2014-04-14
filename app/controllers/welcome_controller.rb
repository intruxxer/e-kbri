class WelcomeController < ApplicationController
  def index	
    if !user_signed_in? then
      @ip_visitor = request.remote_ip
      session[:ip_address]  = @ip_visitor
      @visitor =  Visitor.new( ip_address: @ip_visitor.to_s, action: "Visiting Main Page")
      if @visitor.valid?
        @visitor.save!
      end
      flash[:warning] = "Please take note that your IP is automatically logged for monitoring during access to E-KBRI. Your IP address is: #{@ip_visitor}. "
    end
  	if user_signed_in?
  	  @userreport = Report.where(user_id: current_user.id).where(is_valid: true).desc(:updated_at)
  	  if current_user.has_role? :admin then
  	    @uservisa = Visa.all
  	    @userpassport = Passport.all
  	    
  	  else
  	    visadata = Visa.where(user_id: current_user)

        @uservisa = Visa.where(user_id: current_user.id)
        
        passportdata = Passport.where(user_id: current_user)
        @userpassport = Passport.where(user_id: current_user.id)

        
        
        allunpaidvisa = Visa.where(user_id: current_user, status: 'Received')
        @unpaidvisa = {}
        if allunpaidvisa.count > 0
           allunpaidvisa.each do |x|
            @unpaidvisa[ "ref_id"=> x.ref_id, "category_type" => x.category_type,
                         "first_name" => x.first_name, "last_name" => x.last_name ]
            end
        end
  	  end
=begin  	  	
    		#if there is at least once visa/passport/report application, 
    		#then visadata == 1 as for the current user
    		if visadata.count > 0
          @uservisa.each do |x|
            puts x.inspect
          end
        end
    		if passportdata.count > 0
          @userpassport.each do |x|
            puts x.inspect
          end
        end
    		
    		if @userreport.count > 0
    			@userreport.each do |x|
    				puts x.inspect
    			end
    		end
=end    		
    	end
  end
  
  def showsamplebayar
    
  end
  
  def concept
    #E-KBRI Concepts
  end
  
end