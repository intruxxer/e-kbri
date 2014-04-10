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
  
end
