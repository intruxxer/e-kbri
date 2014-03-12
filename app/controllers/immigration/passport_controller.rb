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
  
  end  
  
  def exec_toSPRI
    @passport = Passport.find(params[:id])
    
    params.require(:passport).permit(:passport_no,:reg_no)
    
    db = Accessdb.new( TARGET_SPRI_FOLDER + 'SPRI3.mdb' )
    db.open()    
    
    db.execute("DELETE * FROM tblData WHERE [noPass] = '" + params[:passport][:passport_no] + "' ")
    
    if db.execute("INSERT INTO tblData(alasanBuat, sponsorLuar, negaraLuar, alamatLuar, kotaLuar, telpLuar, telpDalam, alamatDalam, kelurahan, kabupaten, kecamatan, noPass, noReg, tglKeluar, tglExpire, namaLkP, tmpLahir, tglLahir, jmlHal, noLama, tglKeluarLama, tmpKeluarLama, idCode, KantorPerwakilan, jnsKel, statusWN, namaKlrg) 
        VALUES('" + @passport.application_reason + "','" +  @passport.jobStudyOrganization.to_s + "','KOREA SELATAN','" +  @passport.addressKorea.to_s + "','" +  @passport.cityKorea.to_s + "','" +  @passport.phoneKorea.to_s + "','" +  @passport.phoneIndonesia.to_s + "','" +  @passport.addressIndonesia.to_s + "','" +  @passport.kelurahanIndonesia.to_s + "','" +  @passport.kabupatenIndonesia.to_s + "','" +  @passport.kecamatanIndonesia.to_s + "','" + params[:passport][:passport_no] + "','" + params[:passport][:reg_no] + "','" + Time.new.year.to_s + "/" + Time.new.month.to_s + "/" + Time.new.day.to_s + "','" + (Time.new.year + 5).to_s + "/" + Time.new.month.to_s + "/" + Time.new.day.to_s + "','" + @passport.full_name + "','" + @passport.placeBirth + "','" + @passport.dateBirth.to_s + "','" +  @passport.paspor_type.to_s + "','" + @passport.lastPassportNo + "','" + @passport.dateIssued.to_s + "','" + @passport.placeIssued + "','37A','KBRI SEOUL', '" +  @passport.kelamin.to_s + "', '" +  @passport.citizenship_status.to_s + "','')")
      
       @passport.update_attributes({ :status => 'Printed', :passport_no => params[:passport][:passport_no], :reg_no => params[:passport][:reg_no]})
       
       msg = { :notice => 'Data berhasil dipindahkan' }
       
    else
      
       msg = { :alert => 'Data gagal dipindahkan' }
      
    end    
      
    db.close    
    
    redirect_to '/dashboard/service/passport', msg
  end
  
  def show_all
    @passport = Passport.all   
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @passport = @passport.any_of({:full_name => /#{searchparam}/},{:ref_id => /#{searchparam}/},{:status => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @passport = @passport.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = Passport.count
    iTotalDisplayRecords = @passport.count
    aaData = Array.new    
    
    @passport.each do |passport|
      editLink = "<a href=\"/passports/" + passport.id + "/edit\" target=\"_blank\"><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon-class'>Update Application</span></a>"
      printLink = "<a href=\"/admin/service/prep_spri/" + passport.id + "\" target=\"_blank\"><span class='glyphicon glyphicon-export'></span><span class='glyphicon-class'>Send to SPRI</span></a>"
      aaData.push([ passport.ref_id, passport.full_name, passport.status, editLink + "&nbsp;|&nbsp;" + printLink])                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  private  
    def post_params
      params.require(:passport).permit( :application_type, :application_reason, :paspor_type, :full_name, :kelamin, :placeBirth, :dateBirth,              
      :citizenship_status, :lastPassportNo, :dateIssued, :placeIssued, :jobStudyInKorea, :jobStudyTypeInKorea, :jobStudyOrganization, :jobStudyAddress, 
      :phoneKorea, :addressKorea, :cityKorea, :phoneIndonesia, :addressIndonesia, :kelurahanIndonesia, :kecamatanIndonesia, :kabupatenIndonesia, :dateArrival, :sendingParty, :photo, :status, :payment_slip, :arc, :dateIssuedEnd, :immigrationOffice, :sponsor_address_prov_kr, :sponsor_address_prov_id).merge(owner_id: current_user.id, 
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