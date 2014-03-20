class Immigration::ReportController < ApplicationController  
  before_filter :authenticate_user!
  
  def index
     @report = Report.new
	   if Report.where(user_id: current_user).count > 0
		    redirect_to edit_report_path(current_user)
	   end
  end
  
  def create		
   @report =  Report.new(post_params)
	 current_user.reports = @report
	 if current_user.save
	    respond_to do |format|
        format.html { redirect_to root_path, :notice => "Data Lapor Diri Anda Berhasil Disimpan" }        
      end
   else      
      @errors = @report.errors.messages
      render 'index'
	 end	 	 
  end
  
  #PATCH, PUT /report/:id
  def update
	  #@post = Report.find_by(user_id: params[:id])
	  @report = Report.find(params[:id])
    if @report.update(post_params)
    	 redirect_to :back, :notice => 'Data Lapor Diri Anda Berhasil Diubah!'
    else
      @errors = @report.errors.messages
    	 render 'edit'
    end
  end
  
  def edit   
	   @report = Report.find_by(user_id: params[:id])
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
  
  private
	def post_params	    
		params.require(:report).permit(:name, :height, :birthplace, :datebirth, :marriagestatus, :nopaspor, :dateissued, :dateend, :passportplace, :immigrationOffice, :visatype, :visadateissued, :visadateend,
		:jobStudyInKorea, :jobStudyTypeInKorea, :jobStudyOrganization, :jobStudyAddress,
		:koreanphone, :koreanaddress, :koreanaddresscity, :koreanaddressprovince, :koreanaddresspostalcode, :indonesianphone, :indonesianaddress, :indonesianaddresskelurahan, 
		:indonesianaddresskecamatan, :indonesianaddresskabupaten, :indonesianaddressprovince, :indonesianaddresspostalcode, :relationname, :relationstatus, :relationaddress,
		:relationphone, :relationaddresskelurahan, :relationaddresskecamatan, :relationaddresskabupaten, :relationaddressprovince, :relationaddresspostalcode, :arrivaldate, :indonesianinstance,
		:paspor, :aliencard, :photo, :stayinkorea).merge(owner_id: current_user.id)
	end
  
  
end
