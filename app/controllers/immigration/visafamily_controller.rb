class Immigration::VisafamilyController < ApplicationController
  before_filter :authenticate_user!
  #GET /visa
  def index
    if params[:add_people] then
      @add_people = true
      @lastvisa = Visa.where(visa_type: 2, user_id: current_user).last
      @ref_id = @lastvisa.ref_id
    else
      @ref_id = 'VF-KBRI-'+generate_string+"-"+Random.new.rand(10**5..10**6).to_s
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
        file.write(new_idcard)
      end
   end
   
   uploaded_passport_picture = params[:visa][:photo]
   if (uploaded_passport_picture != nil)
      new_pass_picture = uploaded_passport_picture.read
      File.open(Rails.root.join('public', 'uploads', uploaded_passport_picture.original_filename), 'wb') do |file|
        file.write(new_pass_picture)
      end
   end
   
   uploaded_paymentslip = params[:visa][:slip_photo]
   if (uploaded_paymentslip != nil)
      new_pay_picture = uploaded_paymentslip.read
      File.open(Rails.root.join('public', 'uploads', uploaded_paymentslip.original_filename), 'wb') do |file|
        file.write(new_pay_picture)
      end
   end
   
   uploaded_supdoc = params[:visa][:supdoc]
   if (uploaded_supdoc != nil)
      new_supdoc_picture = uploaded_supdoc.read
      File.open(Rails.root.join('public', 'uploads', uploaded_supdoc.original_filename), 'wb') do |file|
        file.write(new_supdoc_picture)
      end
   end
   
   uploaded_ticket = params[:visa][:supdoc]
   if (uploaded_ticket != nil)
      new_ticket_picture = uploaded_ticket.read
      File.open(Rails.root.join('public', 'uploads', uploaded_ticket.original_filename), 'wb') do |file|
        file.write(new_ticket_picture)
      end
   end
     
   @visa = [ Visa.new(post_params) ]    
    if current_user.visas = @visa then
      current_user.save
      UserMailer.visa_received_email(current_user).deliver
      respond_to do |format|
        format.html { 
          #kalau pertama kali sbg org pertama
          redirect_to :controller => 'visafamily', :action => 'index', 
          :add_people => true, :ref_id => params[:visa][:ref_id]
          #redirect_to visafamilys_path with GET options
          
          #kalau kedua kali 
          
          #kalau finish
          
        }
      end
    else
    redirect_to :back, :notice => "Unfortunately, your current visa application fails to be submitted."
    #do something further 
    end
    #*Debugging*#
    #logger.debug "We are inspecting VISA PROCESSING PARAMS as follows:"
    #puts params.inspect
    #puts @visa.inspect
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
      :sponsor_phone_id, :duration_stays, :duration_stays_unit, 
      :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, 
      :tr_count_dest, :tr_flight_vessel, :tr_air_sea_port, :tr_date_entry, :lim_s_purpose, 
      :lim_s_flight_vessel, :lim_s_air_sea_port, :lim_s_date_entry, :v_purpose, :v_flight_vessel,
      :v_air_sea_port, :v_date_entry, :dip_purpose, :dip_flight_vessel, :dip_air_sea_port, :dip_date_entry, :o_purpose, 
      :o_flight_vessel, :o_air_sea_port, :o_date_entry, :passportpath, :idcardpath, :photopath, :status, :status_code, :payment_slip, 
      :payment_date, :ticketpath, :sup_docpath, :ref_id).merge(owner_id: current_user.id, visa_type: 2)
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