#!/bin/bash

##LYNIS ESSENTIAL SCAN  -- CRON-able for regular execution

lynis audit system --test-from-group malware,authentication,networking,storage,filesystems > /tmp/lynis.partial_scan.log
