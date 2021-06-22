#!/bin/bash

#LYNIS SYSTEM SCAN -- CRON-able for regular execution

lynis audit system > /tmp/lynis.system_scan.log
