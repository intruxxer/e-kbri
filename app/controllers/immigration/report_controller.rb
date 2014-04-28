class Immigration::ReportController < ApplicationController 
  include SimpleCaptcha::ControllerHelpers

  before_filter :authenticate_user!
  
  def index
     @report = Report.new
     @last = Report.where(user_id: current_user).where(is_valid: true)
	   if  @last.count > 0
		    redirect_to edit_report_path(@last.first.id)
	   end
  end
  
  def check
    @report = Report.find(params[:id])
    render layout: "dashboard"
  end
  
  def create		
   @report =  Report.new(post_params)
	 
	 
	 if @report.valid?
	   if simple_captcha_valid?
	     
	     current_user.reports.push(@report)
	     current_user.save
	     
	     current_user.journals.push(Journal.new(:action => 'Create', :model => 'Report', :method => 'Insert', :agent => request.user_agent, :record_id => @report.id ))
	     respond_to do |format|
          format.html { redirect_to root_path, :notice => "Data Lapor Diri Anda Berhasil Disimpan" }        
       end            
      else        
        @errors = { 'Secret Code' => 'Wrong Code Entered'}
        render 'index'
      end
	 else
	   @errors = @report.errors.messages
      render 'index'
	 end	 
	 	 	 
  end
  
  def adminupdate
    @report = Report.find(params[:id])
    if @report.update(post_params)
        
          if @report.is_valid == true
            @col = Report.where(user_id: @report.user_id).ne(id: @report.id)
            @col.each do |row|              
              row.update(is_valid: false)      
              current_user.journals.push(Journal.new(:action => 'Validated : ' + row.is_valid.to_s , :model => 'Passport', :method => 'Update', :agent => request.user_agent, :record_id => row.id ))      
            end
          end
          current_user.journals.push(Journal.new(:action => 'Validated : ' + @report.is_valid.to_s , :model => 'Passport', :method => 'Update', :agent => request.user_agent, :record_id => @report.id ))
          UserMailer.admin_update_report_email(@report).deliver
        
        redirect_to root_path, :notice => 'Anda telah berhasil memperbaharui data lapor diri'
    else
      @errors = @report.errors.messages
      render 'edit'
    end
  end
 
=begin  
  #PATCH, PUT /report/:id
  def update
	  @report = Report.find(params[:id])
	  if @report.update(post_params)
	    current_user.journals.push(Journal.new(:action => 'Updating Report', :model => 'Report', :method => 'Update', :agent => request.user_agent, :record_id => @report.id ))
	    redirect_to :back, :notice => "Revisi Data Lapor Diri Anda Berhasil Disimpan. Silahkan tunggu email konfirmasi dari admin" 
	    if current_user.has_role? :admin or current_user.has_role? :moderator        
        UserMailer.admin_update_report_email(@report).deliver
      end
	  else
	    @errors = @report.errors.messages
	    render 'edit'    
	  end	  
  end
=end

  def update
    #@post = Report.find_by(user_id: params[:id])
    #@report = Report.find(params[:id])
    
    @report = Report.new(post_params)
    #keep every save as new record but not valid until admin verified it
    
    if @report.valid?
      if simple_captcha_valid?
        current_user.reports.push(@report)
        current_user.save
        
        current_user.journals.push(Journal.new(:action => 'Create', :model => 'Report', :method => 'Insert', :agent => request.user_agent, :record_id => @report.id ))
        
        respond_to do |format|
          format.html { redirect_to :back, :notice => "Revisi Data Lapor Diri Anda Berhasil Disimpan. Silahkan tunggu email konfirmasi dari admin" }
        end
      else
        @errors = { 'Secret Code' => 'Wrong Code Entered' }
        render 'edit'
      end
    else
      @errors = @report.errors.messages
      render 'edit'    
    end   
    
  end
  
  def edit   
	   @report = Report.where(id: params[:id]).first
	   #@post = Report.find(params[:id])
  end
  

  def findbyNameandBirth
    params.permit(:name, :datebirth)        
    @report = Report.where( name: params[:name] ).where( datebirth: params[:datebirth] ).all
    catch = { 'ref_id' => 'null' }
    if @report.exists?
      catch = { 'ref_id' => @report.first.ref_id }
    end    
    render :json => catch
  end
  

  def show
    @report = Report.find(params[:id])
    whosign = params[:whosign]
      if whosign == 1 then
          templateReport = "immigration/report/adminprint.html.erb"
      elsif whosign == 2
          templateReport = "immigration/report/adminprinttwo.html.erb"
      else
          templateReport = "immigration/report/adminprint.html.erb"
      end
      respond_to do |format|
      format.html { render 'edit' }
      format.json { render json: @report }
      format.xml  { render xml: @report }
      format.pdf do
        render :pdf            => "Data Lapor Diri [" + @report.name + "]",
               :disposition    => "inline", #{attachment, inline}
               :show_as_html   => params[:debug].present?,
               #:template       => "immigration/visa/visarecapitulation.html.erb",
               :template       => templateReport,
               :encoding       => "utf8"
                              
      end
    end
  end
  

  
  def findbyNameandBirth
    params.permit(:name, :datebirth)        
    @report = Report.where( name: params[:name] ).where( datebirth: params[:datebirth] ).all
    catch = { 'ref_id' => 'null' }
    if @report.exists?
      catch = { 'ref_id' => @report.first.ref_id }
    end    
    render :json => catch
  end
  

  private
	def post_params	    
		params.require(:report).permit(:name, :height, :birthplace, :datebirth, :marriagestatus, :nopaspor, :dateissued, :dateend, :passportplace, :immigrationOffice, :visatype, :visadateissued, :visadateend,
		:jobStudyInKorea, :jobStudyTypeInKorea, :jobStudyOrganization, :jobStudyAddress,
		:koreanphone, :koreanaddress, :koreanaddresscity, :koreanaddressprovince, :koreanaddresspostalcode, :indonesianphone, :indonesianaddress, :indonesianaddresskelurahan, 
		:indonesianaddresskecamatan, :indonesianaddresskabupaten, :indonesianaddressprovince, :indonesianaddresspostalcode, :relationname, :relationstatus, :relationaddress,
		:relationphone, :relationaddresskelurahan, :relationaddresskecamatan, :relationaddresskabupaten, :relationaddressprovince, :relationaddresspostalcode, :arrivaldate, :indonesianinstance,
		:paspor, :aliencard, :photo, :stayinkorea, :is_valid, :ref_id, :no_arc, :comment)
	end
  
  
end
