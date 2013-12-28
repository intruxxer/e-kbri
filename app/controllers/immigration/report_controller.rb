class Immigration::ReportController < ApplicationController

  def index
	
  end
  
  def create
	 uploaded_io = params[:post][:avatar]
	 if (uploaded_io != '')
		newfile = uploaded_io.read
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(newfile)
		end
	 end
		
  
	 report = Report.new(post_params)	      
	 report.save
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
