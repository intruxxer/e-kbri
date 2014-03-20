class Immigration::VisaController < ApplicationController
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
      :sponsor_phone_id, :duration_stays, :duration_stays_unit,
      :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, 
      :tr_count_dest, :tr_flight_vessel, :tr_air_sea_port, :tr_date_entry, :lim_s_purpose, 
      :lim_s_flight_vessel, :lim_s_air_sea_port, :lim_s_date_entry, :v_purpose, :v_flight_vessel,
      :v_air_sea_port, :v_date_entry, :dip_purpose, :dip_flight_vessel, :dip_air_sea_port, :dip_date_entry, :o_purpose, 
      :o_flight_vessel, :o_air_sea_port, :o_date_entry, :passport, :idcard, :photo, :status, :status_code, :payment_slip, 
      :payment_date, :ticket, :sup_doc).merge(owner_id: current_user.id, visa_type: 1)
    end
    #Notes: to add attribute/variable after POST params received, do
    #def post_params
    #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
    #end    
end
