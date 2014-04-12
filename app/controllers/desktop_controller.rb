class DesktopController < ApplicationController
  
  @@SISARICOUNTER = 1000
  @@VIPACOUNTER = 3000
  
  def show_all_lapordiri_history
    @reports = Report.desc(:created_at).where(:is_valid => false).where(:user_id => params[:user_id]).all   
    origin = @reports
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @reports = @reports.any_of({:name => /#{searchparam}/},{:ref_id => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @reports = @reports.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = origin.count
    iTotalDisplayRecords = @reports.count
    aaData = Array.new    
    @reports.desc(:created_at)
    i = 1
    @reports.each do |row|
      
      revisionLink = '-'
      @revision = Report.where(:created_at.gte => row.updated_at)
      if @revision.count > 0
        revisionLink = "<a href=\"/reports/" + @revision.last.id + "/check\">Revisi</a> (" + @revision.last.created_at.strftime("%Y %b %d %H:%M:%S").to_s + ")"
      end
      
      editLink = "<a href=\"/reports/" + row.id + "/edit\" target=\"_blank\"><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon-class'>Update</span></a>"
      checkLink = "<a target=\"_blank\" href=\"/reports/" + row.id + "/check\"><span class='glyphicon glyphicon-eye-open'></span><span class='glyphicon-class'>Check</span></a>"
      #printLink = "<a href=\"/visa/tosisari/" + visa.id + "\"><span class='glyphicon glyphicon-export'></span><span class='glyphicon-class'>Send to SISARI</span></a>"
      
      
      aaData.push([i, row.ref_id, row.name, row.created_at.strftime("%Y %b %d %H:%M:%S").to_s , checkLink ])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  def show_all_lapordiri
    @reports = Report.desc(:created_at).where(:is_valid => true).all   
    origin = @reports
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @reports = @reports.any_of({:name => /#{searchparam}/},{:ref_id => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @reports = @reports.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = origin.count
    iTotalDisplayRecords = @reports.count
    aaData = Array.new    
    
    i = 1
    @reports.desc(:created_at)
    @reports.each do |row|
      
      revisionLink = '-'
      @revision = Report.where(:user_id => row.user_id).where(:created_at.gte => row.updated_at)
      if @revision.count > 0
        revisionLink = "<a href=\"/reports/" + @revision.last.id + "/check\">Revisi</a> (" + @revision.last.created_at.strftime("%Y %b %d %H:%M:%S").to_s + ")"
      end
      
      editLink = "<a href=\"/reports/" + row.id + "/edit\" target=\"_blank\"><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon-class'>Update</span></a>"
      checkLink = "<a href=\"/reports/" + row.id + "/check\"><span class='glyphicon glyphicon-eye-open'></span><span class='glyphicon-class'>Check</span></a>"
      #printLink = "<a href=\"/visa/tosisari/" + visa.id + "\"><span class='glyphicon glyphicon-export'></span><span class='glyphicon-class'>Send to SISARI</span></a>"
      
      
      aaData.push([i, row.ref_id, row.name, row.updated_at.strftime("%Y %b %d %H:%M:%S").to_s, revisionLink , checkLink + "&nbsp;|&nbsp;" + editLink])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  def exec_toSisari
    @visa = Visa.find(params[:id])
    
     params.require(:visa).permit(:pickup_date)
     
     print_code =  @visa.vipa_no.to_s + "/" + Time.new.month.to_s + "/" + Time.new.year.to_s 
    
    if @visa.passport_type == 3 || @visa.category_type == 'diplomatic'
      folderloc = TARGET_SISARI_DIPLOMATIK_FOLDER + 'Visa_diplomatik.mdb'
      query = "INSERT INTO TTVISA(JK, TIPE_VISA, KETPEKERJAAN, LAMA,TYPELAMA, NO_APLIKASI, JENIS, KDPERWAKILAN, NMPERWAKILAN, TGL_DOC, NO_PASPOR, TGL_VALID_PASPOR, TGL_KLUAR_PASPOR, KTR_KLUAR_PASPOR, FLAGACCLOKET, NAMA3, GIVEN_NAME, TGL_LAHIR, TMP_LAHIR, ENTRIES, TGLENTRY, TGL_UPDATE) 
        VALUES('" + @visa.sex.to_s + " " + @visa.marital_status.to_s + "','" + @visa.visa_type.to_s + "','" + @visa.profession.to_s + "'," + @visa.duration_stays.to_s + ",'" + @visa.duration_stays_unit.to_s + "','" + print_code + "','P','A', 'KOR', '" + @visa.created_at.strftime("%m/%d/%Y").to_s + "','" + @visa.passport_no.to_s + "','" + @visa.passport_date_expired.to_s + "','" + @visa.passport_date_issued.to_s + "','" + @visa.passport_issued.to_s + "','Y','" + @visa.last_name.to_s + "','" + @visa.first_name.to_s + "','" + @visa.dateBirth.strftime("%m/%d/%Y") + "','" + @visa.placeBirth.to_s + "','" + @visa.num_entry.to_s + "','" + @visa.created_at.strftime("%m/%d/%Y").to_s + "','" + @visa.updated_at.strftime("%m/%d/%Y").to_s + "')"
      else
      folderloc = TARGET_SISARI_FOLDER + 'Visa.mdb'
	  consularname = Reference.first.consulat_name
      query = "INSERT INTO TTVISA(JK, TIPE_VISA, KETPEKERJAAN, LAMA,TYPELAMA, NO_APLIKASI, JENIS, KDPERWAKILAN, NMPERWAKILAN, TGL_DOC, KODE_NEG, WARGA_NEG, NO_PASPOR, TGL_VALID_PASPOR, TGL_KLUAR_PASPOR, KTR_KLUAR_PASPOR, FLAGACCLOKET, NAMA3, GIVEN_NAME, TGL_LAHIR, TMP_LAHIR, ENTRIES, TGLENTRY, TGL_UPDATE, KD_VISA, Pejabat_ttd, jabatan_ttd) 
        VALUES('" + @visa.sex.to_s + " " + @visa.marital_status.to_s + "','" + @visa.visa_type.to_s + "','" + @visa.profession.to_s + "'," + @visa.duration_stays.to_s + ",'" + @visa.duration_stays_unit.to_s + "','" + print_code + "','I','37A', 'SEOUL', '" + @visa.created_at.strftime("%m/%d/%Y").to_s + "','KOR','KOREA, REPUBLIC OF','" + @visa.passport_no.to_s + "','" + @visa.passport_date_expired.to_s + "','" + @visa.passport_date_issued.to_s + "','" + @visa.passport_issued.to_s + "','Y','" + @visa.last_name.to_s + "','" + @visa.first_name.to_s + "','" + @visa.dateBirth.strftime("%m/%d/%Y") + "','" + @visa.placeBirth.to_s + "','" + @visa.num_entry.to_s + "','" + @visa.created_at.strftime("%m/%d/%Y").to_s + "','" + @visa.updated_at.strftime("%m/%d/%Y").to_s + "','Biasa','" + consularname + "','COUNSELLOR')"  
    end
    
    db = Accessdb.new( folderloc )
    db.open('imigrasiRI')    
    
        
             
    #begin      
      
      db.execute(query)      
      @visa.update_attributes({:print_code => print_code,:status => 'Printed', :vipa_no => nextCounter, :printed_date => Time.now, :pickup_date => params[:visa][:pickup_date]})       
    begin   
       msg = { :notice => 'Data berhasil dipindahkan' }
    rescue 
       msg = { :flash => { warning: "Data Gagal dipindahkan" } }
    end   
      
    db.close   
    
    redirect_to '/dashboard/service/visa', msg
  end
  
  
  
  def show_all_sisari
    @visas = Visa.desc(:created_at).all   
    
    params.permit(:sSearch,:iDisplayLength,:iDisplayStart)
    
    unless (params[:sSearch].nil? || params[:sSearch] == "")    
      searchparam = params[:sSearch]  
      @visas = @visas.any_of({:full_name => /#{searchparam}/},{:ref_id => /#{searchparam}/},{:status => /#{searchparam}/})
    end   
    
    unless (params[:iDisplayStart].nil? || params[:iDisplayLength] == '-1')
      @visas = @visas.skip(params[:iDisplayStart]).limit(params[:iDisplayLength])      
    end    
    
    iTotalRecords = Visa.count
    iTotalDisplayRecords = @visas.count
    aaData = Array.new    
    
    i = 1
    
    @visas.each do |visa|
      editLink = "<a href=\"/visas/" + visa.id + "/edit\" target=\"_blank\"><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon-class'>Update</span></a>"
      checkLink = "<a href=\"/visas/" + visa.id + "/check\"><span class='glyphicon glyphicon-eye-open'></span><span class='glyphicon-class'>Check</span></a>"
      #printLink = "<a href=\"/visa/tosisari/" + visa.id + "\"><span class='glyphicon glyphicon-export'></span><span class='glyphicon-class'>Send to SISARI</span></a>"
      
      paymentdate = !(visa.payment_date.nil?) ? visa.payment_date.strftime("%-d %b %Y") : '-'
      retrievedate = !(visa.printed_date.nil?) ? ('<a style="color:#009933;font-weight:bold;">' + (visa.printed_date+3).strftime("%-d %b %Y") + '</a>').html_safe : '-'
      
      
      aaData.push([i, visa.ref_id, visa.print_code, visa.first_name + " " + visa.last_name , visa.status, visa.created_at.strftime("%-d %b %Y") , paymentdate, retrievedate, checkLink + "&nbsp;|&nbsp;" + editLink])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
  def exec_toSPRI
    @passport = Passport.find(params[:id])
    
    params.require(:passport).permit(:passport_no,:reg_no,:lapordiri_no,:pickup_date)
    
    db = Accessdb.new( TARGET_SPRI_FOLDER + 'SPRI3.mdb' )
    db.open()    
    
    db.execute("DELETE * FROM tblData WHERE [noPass] = '" + params[:passport][:passport_no] + "' ")
    
    begin
      db.execute("INSERT INTO tblData(noFile, pekerjaan, alasanBuat, sponsorLuar, negaraLuar, alamatLuar, kotaLuar, telpLuar, telpDalam, alamatDalam, kelurahan, kabupaten, kecamatan, noPass, noReg, tglKeluar, tglExpire, namaLkP, tmpLahir, tglLahir, jmlHal, noLama, tglKeluarLama, tmpKeluarLama, idCode, KantorPerwakilan, jnsKel, statusWN, namaKlrg) 
        VALUES('" + params[:passport][:lapordiri_no] + "','" + @passport.jobStudyAddress + "','" + @passport.application_reason + "','" +  @passport.jobStudyOrganization.to_s + "','KOREA SELATAN','" +  @passport.addressKorea.to_s + "','" +  @passport.cityKorea.to_s + "','" +  @passport.phoneKorea.to_s + "','" +  @passport.phoneIndonesia.to_s + "','" +  @passport.addressIndonesia.to_s + "','" +  @passport.kelurahanIndonesia.to_s + "','" +  @passport.kabupatenIndonesia.to_s + "','" +  @passport.kecamatanIndonesia.to_s + "','" + params[:passport][:passport_no] + "','" + params[:passport][:reg_no] + "','" + Time.new.year.to_s + "/" + Time.new.month.to_s + "/" + Time.new.day.to_s + "','" + (Time.new.year + 5).to_s + "/" + Time.new.month.to_s + "/" + Time.new.day.to_s + "','" + @passport.full_name + "','" + @passport.placeBirth + "','" + @passport.dateBirth.to_s + "','" +  @passport.paspor_type.to_s + "','" + @passport.lastPassportNo + "','" + @passport.dateIssued.to_s + "','" + @passport.placeIssued + "','37A','KBRI SEOUL', '" +  @passport.kelamin.to_s + "', '" +  @passport.citizenship_status.to_s + "','')")
      @passport.update_attributes({ :status => 'Printed', :passport_no => params[:passport][:passport_no], :reg_no => params[:passport][:reg_no],:printed_date => Time.now, :pickup_date => params[:passport][:pickup_date]})      
       
      msg = { :notice => 'Data berhasil dipindahkan' }  
        
    rescue Exception=>e
      
      msg = { :flash => { warning: "Data Gagal dipindahkan" } }
      
    end    
      
    db.close    
    
    redirect_to '/dashboard/service/passport', msg
  end
  
  def show_all_spri
    @passport = Passport.desc(:created_at).all   
    
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
    
    
    i = 1
    @passport.each do |passport|
      #deleteLink = "<a rel=\"nofollow\" data-method=\"delete\" href=\"/passports/" + passport.id + "\"><span class='glyphicon glyphicon-trash'></span><span class='glyphicon-class'>Delete</span></a>"
      editLink = "<a href=\"/passports/" + passport.id + "/edit\" target=\"_blank\"><span class='glyphicon glyphicon-pencil'></span><span class='glyphicon-class'>Edit</span></a>"
      #printLink = "<a href=\"/admin/service/prep_spri/" + passport.id + "\" target=\"_blank\"><span class='glyphicon glyphicon-export'></span><span class='glyphicon-class'>Send to SPRI</span></a>"
      checkLink = "<a href=\"/passports/" + passport.id + "/check\"><span class='glyphicon glyphicon-eye-open'></span><span class='glyphicon-class'>Check</span></a>"
      
      paymentdate = !(passport.payment_date.nil?) ? passport.payment_date.strftime("%-d %b %Y") : '-'
      retrievedate = !(passport.printed_date.nil?) ? ('<a style="color:#009933;font-weight:bold;">' + (passport.printed_date+1).strftime("%-d %b %Y") + '</a>').html_safe : '-'
      
      aaData.push([i, passport.ref_id, passport.full_name, passport.status, passport.created_at.strftime("%-d %b %Y"), paymentdate , retrievedate , checkLink + "&nbsp;|&nbsp;" + editLink + "&nbsp;"])
      i += 1                        
    end
    
    respond_to do |format|
      format.json { render json: {'sEcho' => params[:sEcho].to_i , 'aaData' => aaData , 'iTotalRecords' => iTotalRecords, 'iTotalDisplayRecords' => iTotalDisplayRecords } }
    end
    
  end
  
end
