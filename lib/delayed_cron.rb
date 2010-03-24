require "active_support"
require "rake"

module Delayed
  class Cron

    attr_reader :interval, :priority

    def initialize
      @interval = (ENV["DELAYED_CRON_INTERVAL"] || 5).to_i   # minutes
      @priority = (ENV["DELAYED_CRON_PRIORITY"] || 0).to_i
    end

    def perform
      schedule_next
      Rake::Task["cron"].execute
    end

    def schedule_next
      Delayed::Job.enqueue self, priority, interval.minutes.from_now.getutc
    end

  end
end
