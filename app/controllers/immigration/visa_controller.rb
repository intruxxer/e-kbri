class Immigration::VisaController < ApplicationController
  #GET /visa
  def index
    if Visa.where(user_id: current_user).count > 0
        redirect_to edit_visa_path(current_user)
     end
  end
  
  #GET /new
  def new
  
  end

  #POST /visa
  def create
    
   uploaded_passport = params[:visa][:passport]
   if (uploaded_passport != nil)
      new_passport = uploaded_passport.read
      File.open(Rails.root.join('public', 'uploads', uploaded_passport.original_filename), 'wb') do |file|
        file.write(new_passport)
      end
   end
   
   uploaded_idcard = params[:visa][:idcard]
   if (uploaded_idcard != nil)
      new_idcard = uploaded_idcard.read
      File.open(Rails.root.join('public', 'uploads', uploaded_idcard.original_filename), 'wb') do |file|
        file.write(uploaded_idcard)
      end
   end
   
   uploaded_passport_picture = params[:visa][:photo]
   if (uploaded_passport_picture != nil)
      new_pass_picture = uploaded_passport_picture.read
      File.open(Rails.root.join('public', 'uploads', uploaded_passport_picture.original_filename), 'wb') do |file|
        file.write(uploaded_passport_picture)
      end
   end
   
    @visa = Visa.new(post_params)
    if @visa.save then
      #current_user.visa = @visa 
      UserMailer.visa_received_email(current_user).deliver
      respond_to do |format|
        format.html { redirect_to :back, :notice => "Your visa application is successfully received!" }
        format.json { render json: {action: "JSON Creating Visa", result: "Saved"} }
        format.js #if being asked by AJAX to return "script" <-->
            #visa_processing/create.js.erb -->to execute script JS,
            #like stopping loading.gif, hiding the element, alerting user
      end
    else
    redirect_to :back, :notice => "Unfortunately, your current visa application fails to be submitted."
    #do something further 
    end
  
    #debugging
    logger.debug "We are inspecting VISA PROCESSING PARAMS as follows:"
    puts params.inspect
    puts @visa.inspect
  end

  #GET visa/:id
  def show
    user_id = params[:id]
    @visa = Visa.find(user_id)
      respond_to do |format|
      format.html #visa_processing/show.html.erb
      format.json { render json: @visa }
      format.xml { render xml: @visa }
    end
  end

  #GET /visa/:id/edit
  def edit
  
  end
  
  #PATCH, PUT /visa
  def update 
  
  end
  
  #DELETE /visa
  def destroy 
  
  end
  
  private
    def post_params
      params.require(:visa).permit(:application_type, :category_type, :full_name, :sex, :email, :picture_path,
      :placeBirth, :dateBirth, :marital_status, :nationality, :profession, :passport_no, :passport_no,
      :passport_issued, :passport_type, :passport_date_issued, :passport_date_expired, :sponsor_type_kr,
      :sponsor_name_kr, :sponsor_address_kr, :sponsor_phone_kr, :sponsor_type_id, :sponsor_name_id, 
      :sponsor_address_id, :sponsor_phone_id, :duration_stays_day, :duration_stays_month, :duration_stays_year, 
      :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, 
      :tr_count_dest, :tr_flight_vessel, :tr_air_sea_port, :tr_date_entry, :lim_s_purpose, 
      :lim_s_flight_vessel, :lim_s_air_sea_port, :lim_s_date_entry, :v_purpose, :v_flight_vessel,
      :v_air_sea_port, :v_date_entry, :dip_purpose, :dip_flight_vessel, :dip_air_sea_port, :dip_date_entry, :o_purpose, 
      :o_flight_vessel, :o_air_sea_port, :o_date_entry, :passportpath, :idcardpath, :photopath)
    end
    #Notes: to add attribute/variable after POST params received, do
    #def post_params
    #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
    #end
    
end
