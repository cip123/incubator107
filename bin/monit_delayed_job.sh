#!/usr/bin/env bash

if [ $# -lt 2 ] ; then
    echo "Usage:   " $0 " <start | stop> <environment>"
    exit 1
fi

action=$1
export RAILS_ENV=$2
export PATH=$PATH:/usr/local/bin

script_location=$(cd ${0%/*} && pwd -P)
cd $script_location/..
rails_root=`pwd`

bundle exec ./bin/delayed_job $action --pid-dir=tmp/pids >> log/delayed_job 2>&1
