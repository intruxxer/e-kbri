ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.mandrillapp.com",  
  :port                 => 587,  
  :domain               => "id-embassy.kr",  
  :user_name            => "x@kbri.seoul.kr",  
  :password             => "xxXXXxxx",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}
