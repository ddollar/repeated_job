require File.expand_path("../spec_helper", __FILE__)

describe "Delayed::Cron" do

  describe "configuration" do

    it "has a configurable interval" do
      ENV["DELAYED_CRON_INTERVAL"] = "10"
      Delayed::Cron.new.interval.should == 10
    end

    it "has a configurable priority" do
      ENV["DELAYED_CRON_INTERVAL"] = "1"
      Delayed::Cron.new.interval.should == 1
    end

    it "has a default interval of 5 minutes" do
      ENV.delete("DELAYED_CRON_INTERVAL")
      Delayed::Cron.new.interval.should == 5
    end

    it "has a default priority of 0" do
      ENV.delete("DELAYED_CRON_PRIORITY")
      Delayed::Cron.new.priority.should == 0
    end

  end

  describe "scheduling" do

    before(:each) do
      @cron = Delayed::Cron.new
    end

    it "knows how to schedule itself" do
      ENV["DELAYED_CRON_INTERVAL"] = "5"

      Delayed::Job.should_receive(:enqueue) do |object, priority, scheduled|
        object.should   == @cron
        priority.should == @cron.priority
        (scheduled - Time.now).should be_close(300, 5)
      end

      @cron.schedule_next
    end

    it "should schedule itself again when executing" do
      @was_run = false
      task(:cron) { @was_run = true }

      @cron.should_receive(:schedule_next)
      @cron.perform

      @was_run.should be_true
    end

  end

end
