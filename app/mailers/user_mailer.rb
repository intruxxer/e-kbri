class UserMailer < ActionMailer::Base
  # default from: "welcome-no-reply@openticket.net"
  
  def visa_received_email(user)
  	@url = "http://kbri.seoul.kr"
  	@email = user.email
  	attachments["garuda.png"] = File.read("#{Rails.root}/public/assets/images/garuda.png")
  	#attachments["ot-presentation-small.png"] = File.read("#{Rails.root}/public/images/ot-presentation-small.png")
  	mail(
  		:to => visa.email, 
  		:subject => "Thank you for using e-KBRI to gain entry to Indonesia!", 
  		:from => "Administrator of e-KBRI <admin@kbri.seoul.kr>",
  		:reply_to => "Visa Counsel of KBRI <visa@kbri.seoul.kr>" 
  		)
  end
end
