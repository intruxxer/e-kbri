class VisaProcessingController < ApplicationController

#GET /visa_processing
def index

end

#GET /visa_processing/new
def new

end

#POST /visa_processing
def create
  #under_construction 
  @visa = Visa.new(application_type category_type
  				   full_name: params[:full_name], sex: params[:sex],
  				   email: params[:email], picture_path: params[:picture_path]
  				   placeBirth dateBirth marital_status nationality
  				   profession passport_no passport_issued passport_type
  				   passport_date_issued passport_date_expired
  				   sponsor_type_kr sponsor_name_kr sponsor_address_kr
  				   sponsor_phone_kr sponsor_type_id sponsor_name_id sponsor_address_id
  				   sponsor_phone_id duration_stays_day duration_stays_month
  				   duration_stays_year num_entry 
  				   checkbox_1 checkbox_2 checkbox_3 checkbox_4 checkbox_5
  				   checkbox_6 checkbox_7 tr_country_destination tr_flight_vessel
  				   tr_air_sea_port tr_date_entry lim_s_purpose lim_s_flight_vessel
  				   lim_s_air_sea_port lim_s_date_entry v_purpose v_flight_vessel
  				   v_air_sea_port v_date_entry dip_purpose dip_flight_vessel
  				   dip_air_sea_port dip_date_entry o_purpose o_flight_vessel
  				   o_air_sea_port o_date_entry
  		)
  if @visa.save then
    flash[:notice] = "Your visa application is successfully saved!"
    UserMailer.visa_received_email(@visa).deliver
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { "action": "JSON Creating Visa" } }
      format.js #if being asked by AJAX to return "script" <-->
      			#visa_processing/create.js.erb -->to execute script JS,
      			#like stopping loading.gif, hiding the element, alerting user
    end
  else
    flash[:notice] = "Unfortunately, your visa application fails to be submitted."
    #do something further 
  end
  
  #debugging
  logger.debug "We are inspecting VISA PROCESSING PARAMS as follows:"
  puts params.inspect
  puts @visa.inspect
end

#GET visa_processing/:id
def show
  user_id = params[:id]
  @visa = Visa.find(user_id)
    respond_to do |format|
	  format.html #visa_processing/show.html.erb
	  format.json { render json: @visa }
	  format.xml { render xml: @visa }
  end
end

#GET /visa_processing/edit
def edit

end

#PATCH, PUT /visa_processing
def update 

end

#DELETE /visa_processing
def destroy 

end

end
