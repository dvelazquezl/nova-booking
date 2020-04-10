

env :PATH, ENV['PATH']
#para pruebas de manera local
#set :environment, "development"
set :output, {:error => "log/cron_error.log", :standard => "log/cron_log.log"}

#set :output, '/log/cron_error.log'


#every 1.day, at: '08:00 am' do
#rake "email_booking:request_assess"
#end

every 5.minutes do
 rake "email_booking:request_assess"
end
