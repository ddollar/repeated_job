$:.unshift File.expand_path("../../lib", __FILE__)

require "rubygems"

require "spec"
require "spec/autorun"

require "repeated_job"

module Delayed
  class Job
  end
end
