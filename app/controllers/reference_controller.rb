class ReferenceController < ApplicationController
  layout "dashboard"
  def index
    @passportfee = Passportfee.all
    @visafee = Visafee.all
    @reference = Reference.first
    
  end
  
  def create
    
  end
  
  def edit
    case params[:type]
    when "visafee"
      @visafee = Visafee.find(params[:id])
      render "visafee_edit"
    when "passportfee" 
      @passportfee = Passportfee.find(params[:id])
      render "passportfee_edit"
    else
      @reference = Reference.first
      render "reference_edit"    
    end
  end  
 
  def update_visafee
    if !params[:visafee][:type].blank?
      @visafee = Visafee.find(params[:visafee][:id])
      if @visafee.update(visafee_post_params)
        redirect_to dashboard_reference_list_path, :notice => "You have successfully updated visa #{@visafee.name_of_visa}'s fee."
      else
        @errors = @visafee.errors.messages
        render 'edit'
      end
    end
  end
  
  def update_passportfee
    if !params[:passportfee][:type].blank?
      @passportfee = Passportfee.find(params[:passportfee][:id])
      if @passportfee.update(passportfee_post_params)
        redirect_to dashboard_reference_list_path, :notice => "You have successfully updated Passport #{@passportfee.passport_type}'s fee."
      else
        @errors = @passportfee.errors.messages
        render 'edit'
      end
    end
  end
  
  def update_reference
    if !params[:reference][:type].blank?
      @reference = Reference.first
      if @reference.update(reference_post_params)
        redirect_to dashboard_reference_list_path, :notice => "You have successfully updated Person In-Charge."
      else
        @errors = @reference.errors.messages
        render 'edit'
      end
    end
  end
 
  private 
   
  def visafee_post_params()
    params.require(:visafee).permit(:fee_of_visa)
  end
  def passportfee_post_params()
    params.require(:passportfee).permit(:passport_fee)
  end
  def reference_post_params()
    params.require(:reference).permit(:consulat_name, :treasurer_name, :embassy_location)
  end
  
end
