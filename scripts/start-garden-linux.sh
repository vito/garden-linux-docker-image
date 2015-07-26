#!/bin/bash

set -e -u -x

lib=$(cd $(dirname $0)/lib && pwd)

# set up /tmp/garden/graph
#
# NB: be sure to source (NOT EXEC), otherwise the
# loopback will be immediately reaped
. $lib/setup-graph.sh

# set up /tmp/garden-/cgroup ahead of time
. $lib/setup-cgroups.sh

# create depot dir for containers to live in
mkdir /tmp/garden/depot

# don't exec! if we exec the trapped loopback cleanup will be orphaned

garden-linux \
  --listenNetwork tcp \
  --listenAddr 0.0.0.0:7777 \
  --debugAddr 0.0.0.0:7776 \
  --graph /tmp/garden/graph \
  --depot /tmp/garden/depot \
  --snapshots /tmp/garden/snapshots \
  --bin /tmp/garden/src/github.com/cloudfoundry-incubator/garden-linux/linux_backend/bin \
  --disableQuotas \
  --allowHostAccess \
  --containerGraceTime 5m
