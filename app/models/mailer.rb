# To change this template, choose Tools | Templates
# and open the template in the editor.

class Mailer < ActionMailer::Base
  default to: "staff@cfbaltimore.com"
  
  def contact(mail_hash)
    @msg = mail_hash["msg"]
    @name = mail_hash["name"]
    @phone = mail_hash["phone"]
    @pref = mail_hash["pref"]
    mail(from: mail_hash["address"],subject: "CFB Contact Us")
  end
end
