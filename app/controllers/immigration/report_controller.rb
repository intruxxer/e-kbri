class Immigration::ReportController < ApplicationController
  def index
	
  end
  
  def create
	 report = Report.new(post_params)	 
	 report.save
  end
  
  private
	def post_params
		params.require(:post).permit(:name, :height, :birthplace, :datebirth, :statuskawin, :nopaspor, :dateissude, :dateend, :tempatpaspor, :visatype, :visadateissued, :visadateend,
		:koreanjob, :koreaninstancename, :koreaninstanceaddress, :koreaninstancephone, :koreaninstancecity, :koreaninstanceprovince, :koreaninstancepostalcode,
		:koreanphone, :koreanaddress, :koreanaddresscity, :koreanaddressprovince, :koreanaddresspostalcode, :indonesianphone, :indonesianaddress, :indonesianaddresskelurahan, 
		:indonesianaddresskecamatan, :indonesianaddresskabupaten, :indonesianaddressprovince, :indonesianaddresspostalcode, :relationname, :relationstatus, :relationaddress,
		:relationphone, :relationaddresskelurahan, :relationaddresskecamatan, :relationaddresskabupaten, :relationaddressprovince, :relationaddresspostalcode, :arrivaldate, :indonesianinstance
		)
	end
 
  
end
