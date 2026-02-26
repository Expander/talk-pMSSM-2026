#!/bin/sh

set -eux

BASEDIR=$(dirname $0)

math -run "<<${BASEDIR}/run_NUHMSSMNoFVHimalaya.m; Quit[]"
