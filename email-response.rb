require 'gmail'
require 'app_conf'

# Create config.yml, with 
# username: gmail username
# password: gmail password
AppConf.load('config.yml')

def send_reply(email_in)
  @gmail.deliver do
    bcc "ianrvaughan@gmail.com"
    to email_in.from
    subject email_in.subject
    body "Thank you for your email.
Attached is a copy of my CV. 
Ian (auto reply bot v1.1)"
    add_file "/media/windows/Documents and Settings/Public/Documents/Dropbox/People/Ian/personal/jobs/CV of Ian Vaughan.docx"
  end
end

@gmail = Gmail.connect(AppConf.username, AppConf.password)

emails = @gmail.inbox.find(:to => "cv@ianvaughan.co.uk")
emails.each {|e| send_reply(emails[0].message)}

@gmail.logout

