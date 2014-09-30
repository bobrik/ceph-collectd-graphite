#!/bin/sh

set -e

envtpl /etc/collectd/collectd.conf.tpl

collectd -f
