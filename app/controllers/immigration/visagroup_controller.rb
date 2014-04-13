class Immigration::VisagroupController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_filter :authenticate_user!

  #GET /visa
  def index
    @visa = Visa.new
    if session[:add_people] then
      @add_people = true

      
      @lastvisa = Visa.where(visa_type: 3, user_id: current_user).last
      session[:current_ref_id] = @lastvisa.ref_id

      puts "Session add_people = True"
      puts "Session current_ref_id = #{session[:current_ref_id]}"
      #@lastvisa = Visa.where(visa_type: 3, user_id: current_user).last
      #@ref_id = @lastvisa.ref_id
    else
      time = Time.new
      coded_date = time.strftime("%y%m%d")
      @ref_id = '3'+coded_date+generate_string(3)
      session[:current_ref_id] = @ref_id 
      puts "1st Session current_ref_id = #{session[:current_ref_id]}"
    end
  end
  
  #GET /new
  def new
  
  end

  #POST /visa
  def create
     

   @visa =  [Visa.new(post_params)]  
   
   
    if session[:add_people] then
      @add_people = true      
      
      @lastvisa = Visa.where(visa_type: 3, user_id: current_user).last
      session[:current_ref_id] = @lastvisa.ref_id
      
    end  
    
    time = Time.new
    coded_date = time.strftime("%y%m%d")
    @ref_id = '1'+coded_date+generate_string(3)
    
    if @visa[0].valid?
      if simple_captcha_valid?
          current_user.visas.push(@visa[0])   
          current_user.save
          current_user.journals.push(Journal.new(:action => 'Created', :model => 'Visa', :method => 'Insert', :agent => request.user_agent, :record_id => @visa[0].id ))
          UserMailer.visa_received_email(current_user).deliver
          #flash[:notice] = 'Pengurusan aplikasi paspor anda, berhasil!'
          #render 'pasporconfirm.html.erb'
          if session[:add_people].nil? or session[:add_people].blank? or session[:add_people] == false
             session[:add_people] = true
          end
          flash[:notice] = 'Application saved successfully. You may add another person or end your application by clicking "Finish" '
          redirect_to :controller => 'visagroup' , :action => 'index' 
      else        
        @visa = @visa[0]
        @errors = { 'Secret Code' => 'Wrong Code Entered'}
        render 'index'
      end
    else
     @visa = @visa[0]
      @errors = @visa[0].errors.messages
      render 'index'
    end  
    

    #*Debugging*#
    # logger.debug "We are inspecting VISA PROCESSING PARAMS as follows:"
    # puts params.inspect
    # puts @visa.inspect
  end

  #GET visa/:id
  def show
    @visa = Visa.find(params[:id])
      respond_to do |format|
      format.html #visa_processing/show.html.erb
      format.json { render json: @visa }
      format.xml { render xml: @visa }
    end
  end
  
  #PATCH, PUT /visa/:id
  def update
    #@visa = Visa.find_by(user_id: params[:id])
    @visa = Visa.find(params[:id])
    if @visa.update(post_params)
      current_user.journals.push(Journal.new(:action => @visa.status, :model => 'Visa', :method => 'Update', :agent => request.user_agent, :record_id => @visa.id ))
      redirect_to root_path, :notice => 'You have updated your visa application data!'
    else
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
      :placeBirth, :dateBirth, :marital_status, :nationality, :profession, :passport_no, :passport_no,
      :passport_issued, :passport_type, :passport_date_issued, :passport_date_expired, :sponsor_type_kr,
      :sponsor_name_kr, :sponsor_address_kr, :sponsor_address_city_kr, :sponsor_address_prov_kr, :sponsor_phone_kr, 
      :sponsor_type_id, :sponsor_name_id, :sponsor_address_id, :sponsor_address_kab_id, :sponsor_address_prov_id,
      :sponsor_phone_id, :duration_stays, :duration_stays_unit, :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, 
      :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, :count_dest, :flight_vessel, :air_sea_port, :date_entry,
      :purpose, :passport, :idcard, :photo, :status, :status_code, :slip_photo, :payment_date, :ticket, 
      :supdoc, :ref_id, :approval_no).merge(visa_type: 3)
    end
    #Notes: to add attribute/variable after POST params received, do
    #def post_params
    #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
    #end
    def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      random_characters = ''
      length.times { |i| random_characters << chars[rand(chars.length)] }
      random_characters = random_characters.upcase
    end
end
