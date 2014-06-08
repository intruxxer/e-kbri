class CasesController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_filter :authenticate_user!
  
  def index
    @case = Case.new
  end
  
  def info;  end
  
  def new;  end
  
  def show
    @case = Case.find(params[:id])
      respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @case }
      format.xml { render xml: @case }
      format.pdf do
          render :pdf            => "Laporan Kasus WNI Bermasalah di Korea ["+"#{@case.full_name}"+"]_" + @case.id.to_s.upcase,
                 :disposition    => "inline", #{attachment, inline}                 
                 :template       => "cases/report.html.erb",
                 :layout         => "pdf_layout.html",
                 :encoding       => "utf8"                 
        end

    end
  end
  
  def create
    @case = [ Case.new(post_params) ]   
    tempcache = @case
    @case = @case[0]
    
    if @case.valid?
      if simple_captcha_valid?
          current_user.cases.push(tempcache)   
          current_user.save
          flash[:notice] = 'Aduan WNI Bermasalah di Korea telah dilaporkan ke sistem E-KBRI.'
          #render 'pasporconfirm.html.erb'
          render 'edit'
      else        
        @errors = { 'Kesalahan Kode Verifikasi' => 'Kode yang Anda Masukkan Salah'}
        render 'index'
      end
    else     
      @errors = @case.errors.messages
      render 'index'
    end 
  end
  
  def edit
    @case = Case.find(params[:id])
  end
  
  def update
    @case = Case.find(params[:id])
    if @case.update(post_params)
      if current_user.has_role? :admin or current_user.has_role? :moderator        
        redirect_to :back, :notice => "Data Kasus #{@case.full_name} telah berhasil diupdate."
      else
        redirect_to root_path, :notice => "Data Kasus #{@case.full_name} telah berhasil diperbaharui."
      end     
      
    else
      @errors = @case.errors.messages
      render 'edit'
    end
  end
  
  def destroy
    @case = Case.find(params[:id])
    if @case.delete
      redirect_to :back, :notice => "Data Kasus dengan No. Ref. #{@case.full_name} telah berhasil dihapuskan dari sistem."
    else
      redirect_to :back, :notice => "Data Kasus dengan No. Ref. #{@case.full_name} tidak dapat ditemukan."
    end
  end
  
  private  
    def post_params()
      params.require(:case).permit(
      :status, :full_name, :gender, :place_birth, :date_birth, :passport_no, :passport_place, :passport_date_from, :passport_date_to,  
      :address_id, :kelurahan_id, :kecamatan_id, :kabupaten_id, :provinsi_id, :phone_id, :visa_kr, :visa_kr_type, :visa_kr_from, :visa_kr_to, :address_kr, :city_kr, :province_kr, :phone_kr,         
      :company_kr, :company_address_kr, :company_city_kr, :company_province_kr, :company_phone_kr, :case_type, :case_description, :case_embassy_on_assistance, :case_embassy_post_assistance, 
      :case_embassy_staff_name, :case_remarks, :case_embassy_supporting_doc, :case_embassy_supporting_photo, :case_user_supporting_doc)
      
      #Notes: to add attribute/variable after POST params received, do
      #def post_params
      #  params.require(:post).permit(:some_attribute).merge(user_id: current_user.id)
      #end
    end
end
