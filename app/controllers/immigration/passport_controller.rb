class Immigration::PassportController < ApplicationController
  #GET /passport
  def index
    #1 Person, 1 Application in 5 years
    #if Passport.where(user_id: current_user).count > 0
    #    redirect_to edit_passport_path(current_user)
    #end
    #We comment this as we want to enable multiple paspors and/or SPLPs
  end
  
  #GET /new
  def new
  
  end
  
  #GET passport/:id
  def show
    @passport = Passport.find(params[:id])
      respond_to do |format|
      format.html #visa_processing/show.html.erb
      format.json { render json: @passport }
      format.xml { render xml: @passport }
    end
  end
  
  #POST /passport
  def create
    uploaded_passport_picture = params[:passport][:photo]
    if (uploaded_passport_picture != nil)
      new_pass_picture = uploaded_passport_picture.read
      File.open(Rails.root.join('public', 'uploads', uploaded_passport_picture.original_filename), 'wb') do |file|
        file.write(uploaded_passport_picture)
      end
    end
    
    uploaded_paymentslip_picture = params[:passport][:slip_photo]
    if (uploaded_paymentslip_picture != nil)
      new_pay_picture = uploaded_paymentslip_picture.read
      File.open(Rails.root.join('public', 'uploads', uploaded_paymentslip_picture.original_filename), 'wb') do |file|
        file.write(uploaded_paymentslip_picture)
      end
    end
   
    @passport = [ Passport.new(post_params) ]    
    if current_user.passports = @passport then
      UserMailer.passport_received_email(current_user).deliver
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Pengurusan aplikasi paspor anda, berhasil!" }
        format.json { render json: {action: "JSON Creating Passport", result: "Saved"} }
        format.js #if being asked by AJAX to return "script" <-->
            #passport_processing/create.js.erb -->to execute script JS,
            #like stopping loading.gif, hiding the element, alerting user
      end
    else
    redirect_to :back, :notice => "Mohon maaf, Aplikasi pengurusan paspor anda gagal diproses."
    #do something further 
    end
    #debugging
    #logger.debug "We are inspecting PASSPORT PROCESSING PARAMS as follows:"
    #puts params.inspect
    #puts @passport.inspect
  end
  
  #GET /passport/:id/edit
  def edit
    #@passport = Passport.find_by(user_id: params[:id])
    @passport = Passport.find(params[:id])
  end
  
  #PATCH, PUT /passport/:id
  def update
    @passport = Passport.find(params[:id])
    #@passport = Passport.find_by(user_id: params[:id])
    if @passport.update(post_params)
      redirect_to root_path, :notice => 'Anda telah berhasil memperbaharui data pengurusan paspor anda!'
    else
      render 'edit'
    end
  end
  
  #DELETE /passport
  def destroy 
  
  end
  
  private
    def post_params
      params.require(:passport).permit( :application_type, :application_reason, :full_name, :height, :placeBirth, :dateBirth,              
      :marriage_status, :lastPassportNo, :dateIssued, :placeIssued, :jobStudyInKorea, :jobStudyOrganization, :jobStudyAddress, 
      :phoneKorea, :addressKorea, :phoneIndonesia, :addressIndonesia, :dateArrival, :sendingParty, :photopath, :status, :payment_slip).merge(owner_id: current_user.id, 
      ref_id: 'P-KBRI-'+generate_string+"-"+Random.new.rand(10**5..10**6).to_s)
    end
    #Notes: to add attribute/variable after POST params received, do
    #def post_params
    #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
    #end
    def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      password = ''
      length.times { |i| password << chars[rand(chars.length)] }
      password = password.upcase
    end
end
