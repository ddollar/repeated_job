require "active_support"
require "rake"

module Repeated
  class Job

    attr_reader :interval, :priority

    def initialize
      @interval = (ENV["REPEATED_JOB_INTERVAL"] || 5).to_i   # minutes
      @priority = (ENV["REPEATED_JOB_PRIORITY"] || 0).to_i
    end

    def perform
      schedule_next
      Rake::Task["cron"].execute
    end

    def schedule_next
      Delayed::Job.delete_all "handler like '%Repeated::Job%'"
      Delayed::Job.enqueue self, priority, interval.minutes.from_now.getutc
    end

  end
end
