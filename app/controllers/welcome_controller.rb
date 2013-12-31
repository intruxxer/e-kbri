class WelcomeController < ApplicationController
  def index	
    @latestdata = {}
	if user_signed_in?
		reportdata = Report.where(user_id: current_user)
		if reportdata.count > 0
			reportdata.each do |t|
				@latestdata["lapordiri" + t.id] = {'status' => 'success', 'link' => edit_report_path(current_user), 'name' => 'Pelaporan Data Diri', 'timestamp' => t.updated_at}
			end
		end
	end
  end
  
  def concept
    #to show the concept
  end
  
end
