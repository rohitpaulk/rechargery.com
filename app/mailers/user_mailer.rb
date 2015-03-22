class UserMailer < ActionMailer::Base
  default :from => "Rechargery <hello@rechargery.com>"
  
  def registration_confirmation(user)
  	@user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Your account has been created.")
  end

  def password_reset(user,randompass)
  	@user = user
  	@randompass = randompass
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Your password has been reset.")
  end
  def order_creation(user,order)
    @user = user
    @order = order
    mail(:to => "#{user.name} <#{user.email}>", :bcc => ["rohitkuruvilla@yahoo.co.in"], :subject => "We've received your order.")
  end
  def order_failed(user,order)
    @user = user
    @order = order
    mail(:to => "#{user.name} <#{user.email}>", :subject => "We were unable to process your order.")

  end
  def order_tracked(user,order)
    @user = user
    @order = order
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Your recharge is on it's way.")

  end
  def recharge_successful(user,order)
    @user = user
    @order = order
    mail(:to => "#{user.name} <#{user.email}>",:subject => "Recharge successful")
  end

end