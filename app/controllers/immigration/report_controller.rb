class Immigration::ReportController < ApplicationController
  

  def index
	if Report.where(user_id: current_user).count > 0
		redirect_to edit_report_path(current_user)
	end
  end
  
  def create
	 
	 uploaded_io = params[:post][:avatar]
	 if (uploaded_io != nil)
		newfile = uploaded_io.read
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(newfile)
		end
	 end
		
	 current_user.report = Report.new(post_params)
	 redirect_to edit_report_path(current_user), :notice => 'Data Berhasil Disimpan!'
  end
  
  def update
	@editid = params[:id]
	
	@editid.report = Report.update_attributes(post_params)
	
	redirect_to edit_report_path(@editid), :notice => 'Data Berhasil Diubah!'
  end
  
  def edit	
	
    @editid = params[:id]
	getdata = Report.where(user_id: @editid)
	
	@post = getdata.first
	
	
	respond_to do |format|
		format.html # new.html.erb
		#format.xml  { render :xml => @postz }
	  end
  end
  
  private
	def post_params	    
		params.require(:post).permit(:name, :height, :birthplace, :datebirth, :statuskawin, :nopaspor, :dateissude, :dateend, :tempatpaspor, :visatype, :visadateissued, :visadateend,
		:koreanjob, :koreaninstancename, :koreaninstanceaddress, :koreaninstancephone, :koreaninstancecity, :koreaninstanceprovince, :koreaninstancepostalcode,
		:koreanphone, :koreanaddress, :koreanaddresscity, :koreanaddressprovince, :koreanaddresspostalcode, :indonesianphone, :indonesianaddress, :indonesianaddresskelurahan, 
		:indonesianaddresskecamatan, :indonesianaddresskabupaten, :indonesianaddressprovince, :indonesianaddresspostalcode, :relationname, :relationstatus, :relationaddress,
		:relationphone, :relationaddresskelurahan, :relationaddresskecamatan, :relationaddresskabupaten, :relationaddressprovince, :relationaddresspostalcode, :arrivaldate, :indonesianinstance, :avatarname
		)
		
	end
 
  
end
