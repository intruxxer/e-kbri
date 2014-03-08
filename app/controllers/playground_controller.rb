class PlaygroundController < ApplicationController
  #GET /playground
  def index
    if true then
      
      @visa = Visa.find_by(user_id: current_user)
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Your playground application is successfully received!" }
        format.json { render json:  @visa }
        format.js   { render js: @visa }
        format.pdf  { render pdf: "<p>This will be a PDF document</p>"}
      end
     
    end
  end
  
  def new
  
  end

  #POST /playground
  def create
  
    if true then
      
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Your playground application is successfully received!" }
        format.json { render json: {action: "JSON Creating playground", result: "Saved"} }
        format.js
        format.pdf  do 
          "<p>This will be a PDF document</p>"          
        end
      end
     
    end
    
  end
  
  #POST /playground
  def test
  
    if true then
      
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "Your playground application is successfully received!" }
        format.json { render json: {action: "JSON Creating playground", result: "Saved"} }
        format.js
        format.pdf  do 
          "<p>This will be a PDF document</p>"          
        end
      end
     
    end
    
  end

  #GET /playground/:id
  def show
    
  end
  
  #PATCH, PUT /playground/:id
  def update
    
  end
  
  #GET /playground/:id/edit
  def edit
    
  end
  
  #DELETE /playground/:id
  def destroy 
    
  end
  
  private
    def post_params
      params.require(:playground).permit(:op1, :op2).merge(owner_id: current_user.id, 
      ref_id: 'V-KBRI-'+generate_string+"-"+Random.new.rand(10**5..10**6).to_s)
    end

    def generate_string(length=5)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'
      password = ''
      length.times { |i| password << chars[rand(chars.length)] }
      password = password.upcase
    end
    
end
