class Immigration::PassportController < ApplicationController
  #GET /passport
  @@VIPACOUNTERDEF = 6600
  
  def index
    #1 Person, 1 Application in 5 years
    #if Passport.where(user_id: current_user).count > 0
    #    redirect_to edit_passport_path(current_user)
    #end
    #We comment this as we want to enable multiple paspors and/or SPLPs
    @passport = Passport.new
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
 
    
    @passport = [ Passport.new(post_params) ]
    current_user.passports = @passport    
    
    if current_user.save then      
      UserMailer.passport_received_email(current_user).deliver
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Pengurusan aplikasi paspor anda, berhasil!" }
        format.json { render json: {action: "JSON Creating Passport", result: "Saved"} }
        format.js #if being asked by AJAX to return "script" <-->
            #passport_processing/create.js.erb -->to execute script JS,
            #like stopping loading.gif, hiding the element, alerting user
      end
    else
      @passport = @passport[0]
      @errors = current_user.passports[0].errors.messages
      render 'index'
           
      #redirect_to :back, :alert => current_user.passports[0].errors.messages 
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
      redirect_to :back, :notice => 'Anda telah berhasil memperbaharui data pengurusan paspor anda!'
    else
      @errors = @passport.errors.messages
      render 'edit'
    end
  end
  
  #DELETE /passport
  def destroy 
   @passport = Passport.find(params[:id])
    reference = @passport.ref_id
    if @passport.delete
      redirect_to :back, :notice => "Visa Application of Ref. No #{reference} has been erased."
    else
      redirect_to :back, :notice => "Visa Application of Ref. No #{reference} is not found."
    end
  end    
  
  private  
    def post_params()
      params.require(:passport).permit(:application_type, :application_reason, :paspor_type, :full_name, :height, :kelamin, :placeBirth, :dateBirth,              
      :citizenship_status, :lastPassportNo, :dateIssued, :placeIssued, :jobStudyInKorea, :jobStudyTypeInKorea, :jobStudyOrganization, :jobStudyAddress, 
      :phoneKorea, :addressKorea, :cityKorea, :phoneIndonesia, :addressIndonesia, :kelurahanIndonesia, :kecamatanIndonesia, :kabupatenIndonesia, :dateArrival, :sendingParty, :photo, :status, :payment_slip, :arc, :dateIssuedEnd, :immigrationOffice, :sponsor_address_prov_kr, :sponsor_address_prov_id, :supporting_doc).merge(owner_id: current_user.id, 
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
