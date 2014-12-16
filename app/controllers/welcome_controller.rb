class WelcomeController < ApplicationController
   
  def index	
=begin
    message_one = "Dear Visitor, Please kindly be notified that: <br/><br/>(1) The Indonesian Embassy for Republic of Korea has decided to make adjustment on fees pertaining to consular services such as Visas & Re-entry Application Fees, 
                  effective <b>1 August 2014.</b> Please kindly check the new fees structure prior to making payment for your respective application.".html_safe
    message_two = "<br/>(2) Starting from 18 August 2014, VISA pickup <b>is only available from 09.00 - 12.30</b>".html_safe                
    message_three = "<br/>Thank You & Best Regards,<br/>The Indonesian Embassy for Republic of Korea."
=end
    message_one = "<b>PEMBERITAHUAN/공지 사항/NOTIFICATION</b>".html_safe
    message_two = "<br/>PELAYANAN KONSULER KBRI SEOUL DAN KUKRI BUSAN AKAN TUTUP PADA TANGGAL <b>22 - 31 DESEMBER 2014 DAN 1 JANUARI 2015</b>. PELAYANAN KONSULER AKAN DIBUKA KEMBALI PADA TANGGAL <b>2 JANUARI 2015</b>.
PEMBAYARAN BIAYA PELAYANAN KEKONSULERAN HARUS DILAKUKAN PALING LAMBAT PADA TANGGAL <b>19 DESEMBER 2014</b>.".html_safe
    message_three = "<br/>주한 인도네시아 대사관과 부산 인도네시아 영사관 연말 접수 마감일은 <b>12월 19일까지</b> 입니다. 
<b>2014년 12월 22일부터 12월 31일까지는</b> 비자 접수가 불가합니다.
. <b>1월 1일부터</b> 정상근무 합니다.".html_safe
    message_four = "<br/>THE INDONESIAN EMBASSY IN SEOUL AND THE CONSULAR OFFICE IN BUSAN WILL BE CLOSED FROM <b>DECEMBER 22-31, 2014 AND JANUARY 1, 2015</b>. WE WILL REOPEN ON <b>JANUARY 2, 2015</b>. PAYMENT FOR ALL CONSULAR SERVICE FEE MUST BE PAID THE LATEST ON <b>DECEMBER 19, 2014</b>.".html_safe
    warning = [ message_one, message_two, message_three, message_four ]
    flash[:warning] = warning.join("<br/>").html_safe

=begin
    @ip_visitor = request.remote_ip
    #session[:ip_address]  = @ip_visitor
    if !user_signed_in? then
      @visitorname = "Visitor"
      #session[:warned_on_login] = 0
    else
      @visitorname = current_user.full_name
      # session[:warned_on_login] += 1
      # user_session[:test] = "User session upon logged in."
    end
    @visitor =  Visitor.new( who: @visitorname, ip_address: @ip_visitor.to_s, action: "Visiting Main Page")
    if @visitor.valid?
        @visitor.save!
        if !user_signed_in?
          message_one = "Dear Visitor, Please kindly be notified that your IP address & Location is automatically 
                         logged for security monitoring during your active access to E-KBRI."
          message_two = "Your IP address is<b> #{@ip_visitor} </b>that is identified to be located in <b> #{@visitor.coordinates[0]}&deg; longitude </b> & <b> #{@visitor.coordinates[1]}&deg; latitude</b>."
          warning = [ message_one, message_two ]
          flash[:warning] = warning.join("<br/>").html_safe
        end                         
    end
=end                        
  	if user_signed_in?
  	  @userreport = Report.where(user_id: current_user.id)
  	                .where(is_valid: true).desc(:updated_at).page(params[:page]).per(10)
  	  if current_user.has_role? :admin then
  	    @uservisa = Visa.all.page(params[:page]).desc(:created_at,:ref_id).per(10)
  	    @userpassport = Passport.all.page(params[:page]).desc(:created_at,:ref_id).per(10)
  	    @userreport = Report.all.page(params[:page]).desc(:created_at,:ref_id).per(10)
  	    @usercase = Case.all.page(params[:page]).desc(:created_at).per(10)
  	    
  	  else
  	    #visadata = Visa.where(user_id: current_user)
        @uservisa = Visa.where(user_id: current_user.id).desc(:created_at,:ref_id).page(params[:page]).per(5)
        
        #passportdata = Passport.where(user_id: current_user)
        @userpassport = Passport.where(user_id: current_user.id).desc(:created_at,:ref_od).page(params[:page]).per(5)
        
        #casedata = Case.where(user_id: current_user)
        @usercase = Case.where(user_id: current_user.id).desc(:created_at).page(params[:page]).per(5)

        
        
        allunpaidvisa = Visa.where(user_id: current_user, status: 'Received')
        @unpaidvisa = {}
          if allunpaidvisa.count > 0
             allunpaidvisa.each do |x|
              @unpaidvisa[ "ref_id"=> x.ref_id, "category_type" => x.category_type,
                           "first_name" => x.first_name, "last_name" => x.last_name ]
              end
          end
  	    end		
    end
  end
  
  def showsamplebayar
    
  end
  
  def concept
    #E-KBRI Concepts
  end
  
end