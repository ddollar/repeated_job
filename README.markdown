Repeated::Job
=============

Repeated::Job will use Delayed::Job to call `rake cron` on your app at an
interval you specify.

Installation
============

    script/plugin install git://github.com/ddollar/repeated_job.git

Setup
=====

    ENV["REPEATED_JOB_INTERVAL"] = 5    # in minutes, defaults to 5
    ENV["REPEATED_JOB_PRIORITY"] = 0    # Delayed::Job priority, defaults to 0

Copyright (c) 2010 David Dollar, released under the MIT license
