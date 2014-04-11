class Immigration::VisaController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_filter :authenticate_user!

  
  #GET /visa
  def index
    #if individual 1 person, 1 application
    #if Visa.where(user_id: current_user).count > 0
        #redirect_to root_path
     #end
     #We will have passport
     @visa = Visa.new
     
      time = Time.new
      coded_date = time.strftime("%y%m%d")
      @ref_id = '1'+coded_date+generate_string(3)
      

     #redirect_to :controller => 'immigration/visa', :action => 'index', :type => 2, :format => 'json'
     respond_to do |format|
        format.html { } # {redirect_to root_path, :notice => "Your visa application is successfully received!" }
        format.json { } # {render json: {action: "JSON Creating Visa", result: "Saved", type: "1"} }
        format.js #if being asked by AJAX to return "script" <-->
            #visa_processing/create.js.erb -->to execute script JS,
            #like stopping loading.gif, hiding the element, alerting user
      end
  end
  
  def finishing_application
    app_ref = session[:current_ref_id]
    session[:current_ref_id]  = nil
    session[:add_people] = nil

    
    @visa = Visa.where(:ref_id => @visa[0].ref_id)
          
    flash[:notice] = 'You have ended a recent group/family application under # #{app_ref}. Next application will be another group/family.'
    render 'visaconfirm.html.erb'
    
  #  redirect_to root_path, :notice => "You have ended a recent group/family application under # #{app_ref}. Next application will be another group/family."
  end
  
  def payment
    @visas = Visa.where(:ref_id => params[:ref_id]).all
    @visagrouppayment = Visagrouppayment.where(:ref_id => params[:ref_id]).all
    
    if @visagrouppayment.count > 0
      @visagrouppayment = @visagrouppayment.first
    else
      @visagrouppayment = Visagrouppayment.new
    end 
  end
  
  def update_payment
    @visas = Visa.where(params.require(:visagrouppayment).permit(:ref_id)).all 
    @visagrouppayment = Visagrouppayment.new(params.require(:visagrouppayment).permit(:payment_date, :slip_photo, :ref_id))   
    
    
    if @visagrouppayment.upsert
      
      current_user.journals.push(Journal.new(:action => 'Payment', :model => 'Visagrouppayment', :method => 'Insert', :agent => request.user_agent, :record_id => @visagrouppayment.id ))
      
      Visa.where(params.require(:visagrouppayment).permit(:ref_id)).all.each do |row|
        row.update(params.require(:visagrouppayment).permit(:status, :payment_date, :pickup_office))
        current_user.journals.push(Journal.new(:action => 'Paid', :model => 'Visa', :method => 'Update', :agent => request.user_agent, :record_id => row.id ))
      end
      redirect_to :back, :notice => 'Payment Information Successfully saved!'
    else
      @errors = @visagrouppayment.errors.messages
      render 'payment'
    end       
  end
  
  def show_receipt
    
    @visa = Visa.where(:ref_id => params[:ref_id]).all    
    
    render 'visaconfirm.html.erb'
  end
  
  def reapply
    redirect_to root_path, :notice => "You have successfully notified The Embassy staff #{params[:id]} to recheck your previously incomplete application."
  end
  
  #GET /new
  def new
  
  end


  def check
    @visa = Visa.find(params[:id])
    render layout: "dashboard"
  end

  #POST /visa
  def create
    
    @visa =  [Visa.new(post_params)]
    
    time = Time.new
    coded_date = time.strftime("%y%m%d")
    @ref_id = '1'+coded_date+generate_string(3)
    
    
    if @visa[0].valid?
      if simple_captcha_valid?
          current_user.visas.push(@visa[0])   
          current_user.save
          UserMailer.visa_received_email(current_user).deliver
          current_user.journals.push(Journal.new(:action => 'Created', :model => 'Visa', :method => 'Insert', :agent => request.user_agent, :record_id => @visa[0].id ))
          @visa = Visa.where(:ref_id => @visa[0].ref_id)
          
          flash[:notice] = 'Application Saved successfully!'
          render 'visaconfirm.html.erb'
          #redirect_to root_path, :notice => "Your visa application is successfully received!"
      else        
        
        
        
        @errors = { 'Secret Code' => 'Wrong Code Entered'}
        render 'index'
      end
    else
     
      @errors = @visa[0].errors.messages
      render 'index'

    end
    
  end

  #GET visa/:id
  def show
    @visa = Visa.find(params[:id])
      respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @visa }
      format.xml { render xml: @visa }
      format.pdf do
        render :pdf            => "Visa Application Form ["+"#{current_user.full_name}"+"]",
               :disposition    => "inline", #{attachment, inline}
               :show_as_html   => params[:debug].present?,
               :template       => "immigration/visa/visapayment.html.erb",
               :layout         => "pdf_layout.html"              

      end
    end
  end
  
  #PATCH, PUT /visa/:id
  def update
    #@visa = Visa.find_by(user_id: params[:id])
    @visa = Visa.find(params[:id])
    if @visa.update(post_params)

      
      if current_user.has_role? :admin or current_user.has_role? :moderator
        current_user.journals.push(Journal.new(:action => @visa.status, :model => 'Visa', :method => 'Update', :agent => request.user_agent, :record_id => @visa.id ))
        UserMailer.admin_update_visa_email(@visa).deliver
      end
      
      redirect_to :back, :notice => 'You have updated your visa application data!'

    else
      @errors = @visa.errors.messages
      render 'edit'
    end
  end
  
  #GET /visa/:id/edit
  def edit
    #Why NOT searching based on user_id? because there will be MULTIPLE visas/users
    #Hence, NOT @visa = Visa.find_by(user_id: params[:id]), but
    @visa = Visa.find(params[:id])
  end
  
  #DELETE /visa/:id
  def destroy 
    @visa = Visa.find(params[:id])
    reference = @visa.ref_id
    if @visa.delete
      current_user.journals.push(Journal.new(:action => 'Removed', :model => 'Visa', :method => 'Delete', :agent => request.user_agent, :record_id => params[:id] ))
      redirect_to :back, :notice => "Visa Application of Ref. No #{reference} has been erased."
    else
      redirect_to :back, :notice => "Visa Application of Ref. No #{reference} is not found."
    end
  end  
  
  private
    def post_params
      params.require(:visa).permit(:application_type, :category_type, :first_name, :last_name, :sex, :email,
      :placeBirth, :dateBirth, :marital_status, :nationality, :profession, :profession_detail, :reason, :passport_no, :passport_no,
      :passport_issued, :passport_type, :passport_date_issued, :passport_date_expired, :sponsor_type_kr,
      :sponsor_name_kr, :sponsor_address_kr, :sponsor_address_city_kr, :sponsor_address_prov_kr, :sponsor_phone_kr, 
      :sponsor_type_id, :sponsor_name_id, :sponsor_address_id, :sponsor_address_kab_id, :sponsor_address_prov_id, 
      :sponsor_phone_id, :duration_stays, :duration_stays_unit, :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, 
      :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, :count_dest, :flight_vessel, :air_sea_port, :date_entry, :purpose, 
      :passport, :idcard, :photo, :status, :status_code, :slip_photo, :payment_date, :ticket, :supdoc, :ref_id,
      :approval_no, :visafee_ref, :comment, :pickup_office)

    end
    #Notes: to add attribute/variable after POST params received, do
    #def post_params
    #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
    #end   
    def reference_no_visa
      time = Time.new
      coded_date = time.strftime("%y%m%d")
      ref_id = '1'+coded_date+generate_string(3)
    end
    def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      random_characters = ''
      length.times { |i| random_characters << chars[rand(chars.length)] }
      random_characters = random_characters.upcase
    end 
end
