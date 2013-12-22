class UserMailer < ActionMailer::Base
  # default from: "welcome-no-reply@openticket.net"
  
  def visa_received_email(visa)
  	@url = "http://staging.openticket.net"
  	@email = visa.email
  	attachments["logo.png"] = File.read("#{Rails.root}/public/images/logo.png")
  	attachments["ot-presentation-small.png"] = File.read("#{Rails.root}/public/images/ot-presentation-small.png")
  	mail(
  		:to => visa.email, 
  		:subject => "Thank you for signing up to Open Ticket!", 
  		:from => "Welcome to Open ticket <no-reply@openticket.net>",
  		:reply_to => "Admin Open Ticket <admin@emonkiz.com>" 
  		)
  end
end
