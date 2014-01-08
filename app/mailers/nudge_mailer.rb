class NudgeMailer < MandrillMailer::TemplateMailer
  default from: 'contact@usecurrently.com'
  default from_name: 'Currently'

  def nudge(sender, recipient)
    mandrill_mail template: 'Nudge User',
                  subject: sender.name + ' wants you to update your status',
                  to: 'andrew@andrewlin.net', #change this later
                  vars: {
                    'EMAIL_MESSAGE' => sender.name + " nudged you on Currently. Update your status to let them know what you've been up to!" ,
                    'EMAIL_BUTTON_ADDRESS' => 'http://www.usecurrently.com/friends',
                    'EMAIL_BUTTON_MESSAGE' => 'Update Now'
                  },
                  inline_css: true
  end
end