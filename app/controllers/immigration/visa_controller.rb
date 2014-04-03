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
    redirect_to root_path, :notice => "You have ended a recent group/family application under # #{app_ref}. Next application will be another group/family."
  end
  
  def reapply
    redirect_to root_path, :notice => "You have successfully notified The Embassy staff #{params[:id]} to recheck your previously incomplete application."
  end
  
  #GET /new
  def new
  
  end

  #POST /visa
  def create
    
   @visa = [ Visa.new(post_params) ] 
   current_user.visas = @visa   
    if current_user.save then
      UserMailer.visa_received_email(current_user).deliver
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Your visa application is successfully received!" }
        format.json { render json: {action: "JSON Creating Visa", result: "Saved"} }
        format.js #if being asked by AJAX to return "script" <-->
            #visa_processing/create.js.erb -->to execute script JS,
            #like stopping loading.gif, hiding the element, alerting user
      end
    else
    @errors = @visa[0].errors.messages
    render 'index'
    #redirect_to :back, :notice => "Unfortunately, your current visa application fails to be submitted."
    #do something further 
    end
    
  end

  #GET visa/:id
  def show
    @visa = Visa.find(params[:id])
      respond_to do |format|
      format.html #visa_processing/show.html.erb
      format.json { render json: @visa }
      format.xml { render xml: @visa }
      format.pdf do
        render :pdf            => "Visa Application Form ["+"#{current_user.full_name}"+"]",
               :disposition    => "inline", #{attachment, inline}
               :show_as_html   => params[:debug].present?,
               :template       => "immigration/visa/visarecapitulation.html.erb",
               :layout         => "visa_pdf.html",
               :footer         => { :center => "The Embassy of Republic of Indonesia at Seoul" }
      end
    end
  end
  
  #PATCH, PUT /visa/:id
  def update
    #@visa = Visa.find_by(user_id: params[:id])
    @visa = Visa.find(params[:id])
    if @visa.update(post_params)
      redirect_to root_path, :notice => 'You have updated your visa application data!'
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
      :passport, :idcard, :photo, :status, :status_code, :payment_slip, :payment_date, :ticket, :sup_doc, 
      :approval_no).merge(ref_id: reference_no_visa, owner_id: current_user.id, visa_type: 1)
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
