class UserMailer < ApplicationMailer
  default from: 'ne-pas-repondre@hop-la-pizza.herokuapp.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://hop-la-pizza.herokuapp.com/'
    
    mail(to: @user.email, subject: 'Bienvenue sur Hop-la-pizza!')
  end
end
