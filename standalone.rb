require 'app_conf'
load 'email-response.rb'
#include email-response

# Create config.yml, with
# username: gmail username
# password: gmail password
AppConf.load('config.yml')

er = EmailResponse.new(AppConf.username, AppConf.password)
er.monitor
er.close
