#!/usr/bin/env bash
set -e

[ -f `which ack` ] || (echo 'ack is not installed' >&2 && exit 1)
