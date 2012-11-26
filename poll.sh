#!/bin/bash
LOG=~/dev/foodishere/poll.log
SITE=http://foodishere.herokuapp.com
curl -s -w "`date` %{http_code}" -o /dev/null $SITE >> $LOG
