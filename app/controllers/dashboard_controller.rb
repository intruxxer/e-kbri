class DashboardController < ApplicationController
  before_filter :authenticate_user!#if user_signed_in?, current_user.full_name, etc. 
  before_filter :check_access
  #because /layouts/dashboard.html.erb exists, default layout used is "dashboard"
  
  def index
    @allvisa = Visa.all.count
    @allpassport = Passport.all.count
    @allreport = Report.all.count
  end
  
  def counsel
  
  end
  
  def immigration
    if params[:document] == "visa" then

      @document = "dashboard/service_visa"
      
    elsif params[:document] == "passport"
      @document = "dashboard/service_passport"
      
    elsif params[:document] == "prep_spri" then
      
      vipacounter = 3000      
      
      @document = "dashboard/tospri_prep"
      @passport = Passport.find(params[:id])
      
    elsif params[:document] == "prep_visa" then
      
      @document = "dashboard/tosisari_prep"
      @visa = Visa.find(params[:id])    
       
    elsif params[:document] == "lapordiri" then
      
      @document = "dashboard/service_report"
      
    else  

    
    end
  end
  
  def tabulation
  
  end
  
  def employment_indonesia
  
  end
  
  def employment_korea
    
  end
  
  def statistics
  
  end 
  

  def syncpanel
    
    @syncdata = current_user.sync
    
    @document = "dashboard/syncpanel"
    render 'immigration'
  end 
  
  
  def periodical_reporting
    @layout_part = 'top'
  end
  
  def periodical_reporting_printed_based
    @layout_part = 'top'
  end    
  
  def generate_periodical_reporting
    @layout_part = 'bottom'
    periodical_post_params()
    
    if(params[:periodical][:startperiod].present? && params[:periodical][:endperiod].present?)
      
      
      @daterange = { 'startperiod' => params[:periodical][:startperiod], 'endperiod' => params[:periodical][:endperiod] }
      
      @visa = Visa.where(:payment_date => {'$gte' => params[:periodical][:startperiod],'$lte' => params[:periodical][:endperiod]})
      @passport = Passport.where(:payment_date => {'$gte' => params[:periodical][:startperiod],'$lte' => params[:periodical][:endperiod]})
            
      @passportfee = Passportfee.all
      @visafee = Visafee.all
      
      if(params[:type]=='rekap')
        respond_to do |format|
          format.pdf do
            render :pdf         => "Rekapitulasi Bukti Visa & Paspor " + params[:periodical][:startperiod] + " _ " + params[:periodical][:endperiod] + " (Payment Date Based)",
                   :disposition => "attachment",
                   :template    => 'dashboard/report/pdfs.html.erb',
                   :page_size   => 'A4'                          
                   
          end
        end
        
      else
        respond_to do |format|
          format.pdf do
            render :pdf         => "Rekapitulasi Visa & Paspor " + params[:periodical][:startperiod] + " _ " + params[:periodical][:endperiod] + " (Payment Date Based)",
                   :disposition => "attacment",
                   :template    => 'dashboard/report/rekap.html.erb',
                   :page_size   => 'A4',                           
                   :footer      => { :center => "The Embassy of Republic of Indonesia at Seoul" }
          end
        end
        
      end      
        
    else     
       
       redirect_to :back, :flash => { warning: "Laporan Gagal Dibuat" }
          
    end    
  end
  
  def generate_periodical_reporting_printed_based
    @layout_part = 'bottom'
    periodical_post_params()
    
    if(params[:periodical][:startperiod].present? && params[:periodical][:endperiod].present?)
      
      
      @daterange = { 'startperiod' => params[:periodical][:startperiod], 'endperiod' => params[:periodical][:endperiod] }
      
      @visa = Visa.where(:printed_date => {'$gte' => params[:periodical][:startperiod],'$lte' => params[:periodical][:endperiod]})
      @passport = Passport.where(:printed_date => {'$gte' => params[:periodical][:startperiod],'$lte' => params[:periodical][:endperiod]})
            
      @passportfee = Passportfee.all
      @visafee = Visafee.all
      
      if(params[:type]=='rekap')
        respond_to do |format|
          format.pdf do
            render :pdf         => "Rekapitulasi Bukti Visa & Paspor " + params[:periodical][:startperiod] + " _ " + params[:periodical][:endperiod] + " (Printed Date Based)",
                   :disposition => "attachment",
                   :template    => 'dashboard/report/pdfs.html.erb',
                   :page_size   => 'A4'                          
                   
          end
        end
        
      else
        respond_to do |format|
          format.pdf do
            render :pdf         => "Rekapitulasi Visa & Paspor " + params[:periodical][:startperiod] + " _ " + params[:periodical][:endperiod]  + " (Printed Date Based)",
                   :disposition => "attacment",
                   :template    => 'dashboard/report/rekap.html.erb',
                   :page_size   => 'A4',                           
                   :footer      => { :center => "The Embassy of Republic of Indonesia at Seoul" }
          end
        end
        
      end      
        
    else     
       
       redirect_to :back, :flash => { warning: "Laporan Gagal Dibuat" }
          
    end    
  end
  
  protected
  def group_passportfee_type
      
  end
  

  def check_access
    if !current_user.has_role? :admin then
      redirect_to root_path, :flash => { :warning => "The URL you attempt to access is not exist." }
    else  
    end
  end

  
  def periodical_post_params
    params.require(:periodical).permit(:startperiod, :endperiod, :type)
  end

end
