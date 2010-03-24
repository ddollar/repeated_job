require "delayed_cron"

cron = Delayed::Cron.new
cron.schedule_next
