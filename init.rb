require "repeated_job"

begin
  cron = Repeated::Job.new
  cron.schedule_next
rescue StandardError
  puts "Exception encountered, Repeated::Cron not loaded"
  puts $!
end