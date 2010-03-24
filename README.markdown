Delayed::Cron
=============

Delayed::Cron will use Delayed::Job to call `rake cron` on your app at an
interval you specify.

Installation
============

    script/plugin install git://github.com/ddollar/delayed_cron.git

Setup
=====

    ENV["DELAYED_CRON_INTERVAL"] = 5    # in minutes, defaults to 5
    ENV["DELAYED_CRON_PRIORITY"] = 0    # Delayed::Job priority, defaults to 0

Copyright (c) 2010 David Dollar, released under the MIT license
