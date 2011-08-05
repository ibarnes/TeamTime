class UserMailer < ActionMailer::Base
   def checkin(clock)
     @clock = clock
    mail(:to => 'isaac.barnes@med.navy.mil,jose.risi@med.navy.mil',
      :subject => clock.user.name + " check " + clock.status.downcase + " at " + Time.now.strftime("%I:%M %p"),
      :from => "noreply@theteamtime.com")
  end
end
