class Immigration::VisafamilyController < ApplicationController
   include SimpleCaptcha::ControllerHelpers
   before_filter :authenticate_user!
  #GET /visa
  def index
    @visa = Visa.new
    if session[:add_people] then
      @add_people = true
      @ref_id = session[:current_ref_id]
      puts "Session add_people = True"
      puts "Session current_ref_id = #{session[:current_ref_id]}"
      #@lastvisa = Visa.where(visa_type: 2, user_id: current_user).last
      #@ref_id = @lastvisa.ref_id
    else
      time = Time.new
      coded_date = time.strftime("%y%m%d")
      @ref_id = '2'+coded_date+generate_string(3)
      session[:current_ref_id] = @ref_id
      puts "1st Session current_ref_id = #{session[:current_ref_id]}"
      #@ref_id = 'VF-KBRI-'+generate_string+"-"+Random.new.rand(10**5..10**6).to_s
    end
  end
  
  #GET /new
  def new
  
  end

  #POST /visa
  def create
=begin   
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
=end
     
   @visa = [ Visa.new(post_params) ] 
   current_user.visas = @visa   
    if current_user.save then
      UserMailer.visa_received_email(current_user).deliver
      respond_to do |format|
        format.html { 
          #kalau pertama kali sbg org pertama
          if session[:add_people].nil? or session[:add_people].blank? or session[:add_people] == false
             session[:add_people] = true
          end
          redirect_to :controller => 'visafamily', :action => 'index' 
          #redirect_to visafamilys_path with GET options
          
          #kalau kedua kali 
          
          #kalau finish
          
        }
      end
    else
      @visa = @visa[0]
      @errors = current_user.visas[0].errors.messages
      render 'index'
      #redirect_to :back, :notice => "Unfortunately, your current visa application fails to be submitted."
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
      :sponsor_phone_id, :duration_stays, :duration_stays_unit, :num_entry, :checkbox_1, :checkbox_2, :checkbox_3, 
      :checkbox_4, :checkbox_5, :checkbox_6, :checkbox_7, :count_dest, :flight_vessel, :air_sea_port, :date_entry, 
      :purpose, :passport, :idcard, :photo, :status, :status_code, :payment_slip, 
      :payment_date, :ticketpath, :sup_docpath, :ref_id, :approval_no).merge(owner_id: current_user.id, visa_type: 2)
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
