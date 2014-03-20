class UserMailer < ActionMailer::Base
  #counselor@kbri.seoul.kr alias: {visa, paspor, konsuler}
  
  def visa_received_email(user)
  	@url = "http://kbri.seoul.kr"
  	@email = user.email
  	uservisa = Visa.where(owner_id: user.id).last
  	@ref_id = uservisa.ref_id
  	@uid = user.id
  	attachments["garuda.png"] = File.read("#{Rails.root}/public/assets/images/garuda.png")
  	mail(
  		:to => @email, 
  		:subject => "Thank you for using e-KBRI to gain entry to Indonesia!", 
  		:from => "Administrator of e-KBRI <admin@kbri.seoul.kr>",
  		:reply_to => "Visa Counselor of Indonesian Embassy at Seoul <visa@kbri.seoul.kr>" 
  		)
  end
  
  def passport_received_email(user)
    @url = "http://kbri.seoul.kr"
    @email = user.email
    userpassport = Passport.where(owner_id: user.id).last
    @ref_id = userpassport.ref_id
    @uid = user.id
    attachments["garuda.png"] = File.read("#{Rails.root}/public/assets/images/garuda.png")
    mail(
      :to => @email, 
      :subject => "Terimakasih atas penggunaan e-KBRI untuk pengurusan paspor anda!", 
      :from => "Administrator of e-KBRI <admin@kbri.seoul.kr>",
      :reply_to => "Fungsi Konsuler KBRI Seoul <paspor@kbri.seoul.kr>" 
      )
  end
end
