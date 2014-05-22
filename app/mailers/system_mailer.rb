class SystemMailer < ActionMailer::Base
  
    def visa_received_email(visa)
      @url = "http://id-embassy.kr"
      @email = User.find(visa.user_id).email
  
      @visa = visa
      @ref_id = @visa.ref_id    
      attachments["garuda.png"] = File.read("#{Rails.root}/public/assets/images/garuda.png")
      #attachments["ot-presentation-small.png"] = File.read("#{Rails.root}/public/images/ot-presentation-small.png")
  
      mail(
        :to => @email, 
        :subject => "Thank you for using eKBRI of Indonesian Embassy in Seoul!", 
        :from => "Administrator of eKBRI <admin@kbri.seoul.kr>",
        :reply_to => "Visa Counselor of Indonesian Embassy at Seoul <visa@kbri.seoul.kr>" 
        )
    end
  
end