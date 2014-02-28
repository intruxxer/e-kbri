class Immigration::ReportController < ApplicationController
  

  def index
	   if Report.where(user_id: current_user).count > 0
		    redirect_to edit_report_path(current_user)
	   end
  end
  
  def create
	 
	 uploaded_io = params[:post][:paspor]
	 if (uploaded_io != nil)
		newfile = uploaded_io.read
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(newfile)
		end
	 end
	 
	 uploaded_io2 = params[:post][:aliencard]
	 if (uploaded_io2 != nil)
    newfile = uploaded_io2.read
    File.open(Rails.root.join('public', 'uploads', uploaded_io2.original_filename), 'wb') do |file|
      file.write(newfile)
    end
   end
   
   uploaded_io3 = params[:post][:photo]
   if (uploaded_io3 != nil)
    newfile = uploaded_io3.read
    File.open(Rails.root.join('public', 'uploads', uploaded_io3.original_filename), 'wb') do |file|
      file.write(newfile)
    end
   end
		
	 current_user.report = Report.new(post_params)
	 redirect_to edit_report_path(current_user), :notice => 'Data Berhasil Disimpan!'
  end
  
  #PATCH, PUT /report/:id
  def update
	  @post = Report.find_by(user_id: params[:id])
    if @post.update(post_params)
    	 redirect_to root_path, :notice => 'Data Berhasil Diubah!'
    else
    	 render 'edit'
    end
  end
  
  def edit   
	   @post = Report.find_by(user_id: params[:id])
  end
  
  private
	def post_params	    
		params.require(:post).permit(:name, :height, :birthplace, :datebirth, :marriagestatus, :nopaspor, :dateissued, :dateend, :pasporplace, :visatype, :visadateissued, :visadateend,
		:koreanjob, :koreaninstancename, :koreaninstanceaddress, :koreaninstancephone, :koreaninstancecity, :koreaninstanceprovince, :koreaninstancepostalcode,
		:koreanphone, :koreanaddress, :koreanaddresscity, :koreanaddressprovince, :koreanaddresspostalcode, :indonesianphone, :indonesianaddress, :indonesianaddresskelurahan, 
		:indonesianaddresskecamatan, :indonesianaddresskabupaten, :indonesianaddressprovince, :indonesianaddresspostalcode, :relationname, :relationstatus, :relationaddress,
		:relationphone, :relationaddresskelurahan, :relationaddresskecamatan, :relationaddresskabupaten, :relationaddressprovince, :relationaddresspostalcode, :arrivaldate, :indonesianinstance,
		:pasporname, :aliencardname, :photoname)
	end
 
  
end
