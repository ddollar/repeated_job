require File.expand_path("../spec_helper", __FILE__)

describe "Repeated::Job" do

  describe "configuration" do

    it "has a configurable interval" do
      ENV["REPEATED_JOB_INTERVAL"] = "10"
      Repeated::Job.new.interval.should == 10
    end

    it "has a configurable priority" do
      ENV["REPEATED_JOB_INTERVAL"] = "1"
      Repeated::Job.new.interval.should == 1
    end

    it "has a default interval of 5 minutes" do
      ENV.delete("REPEATED_JOB_INTERVAL")
      Repeated::Job.new.interval.should == 5
    end

    it "has a default priority of 0" do
      ENV.delete("REPEATED_JOB_PRIORITY")
      Repeated::Job.new.priority.should == 0
    end

  end

  describe "scheduling" do

    before(:each) do
      @repeated = Repeated::Job.new
    end

    it "knows how to schedule itself" do
      ENV["REPEATED_JOB_INTERVAL"] = "5"

      Delayed::Job.should_receive(:delete_all).with(/Repeated::Job/)

      Delayed::Job.should_receive(:enqueue) do |object, priority, scheduled|
        object.should   == @repeated
        priority.should == @repeated.priority
        (scheduled - Time.now).should be_close(300, 5)
      end

      @repeated.schedule_next
    end

    it "should schedule itself again when executing" do
      @was_run = false
      task(:cron) { @was_run = true }

      @repeated.should_receive(:schedule_next)
      @repeated.perform

      @was_run.should be_true
    end

  end

end
