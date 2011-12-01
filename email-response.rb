# Polls email account for data
# actions something if found

require 'gmail'
require 'logger'

class EmailResponse
  @@log = Logger.new('log.txt')

  def initialize(name, password)
    log "initialize->name:#{name}, password:#{password}"
    @gmail = Gmail.connect(name, password)
    # if @gmail nil
  end

  def close
    log "close"
    @gmail.logout
  end

  def monitor
    log "monitor"
    emails = @gmail.inbox.find(:unread, :to => "cv@ianvaughan.co.uk")
    emails.each {|e| send_reply(e.message)}
  end

  private

  def send_reply(email_in)
    log "send_reply->email:-\n<<<<\n#{email_in}\n>>>>"
    @gmail.deliver do
      bcc "ianrvaughan@gmail.com"
      to email_in.from
      subject email_in.subject
      body "Thank you for your email.\nAttached is a copy of my CV.\nIan (auto reply bot v1.1)"
      # email will fail to send if file not found
      file = "/media/windows/Documents and Settings/Public/Documents/Dropbox/People/Ian/personal/jobs/CV of IAN VAUGHAN-2011.doc"
      add_file file if File.exists?(file)
    end
    log "send_reply->end"
  end

  def log (params)
   @@log.debug params
  end

end
