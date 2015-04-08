#!/usr/bin/env sh
#
# Dropbear service

# import DroboApps framework functions
. /etc/service.subr

# framework-mandated variables
framework_version="2.1"
name="dropbear"
version="2015.67"
description="SSH server"
depends=""
#webui=""

# app-specific variables
prog_dir="$(dirname "$(realpath "${0}")")"
daemon="${prog_dir}/sbin/dropbear"
tmp_dir="/tmp/DroboApps/${name}"
pidfile="${tmp_dir}/pid.txt"
logfile="${tmp_dir}/log.txt"

start() {
  "${daemon}" -E -p 2222 -P "${pidfile}" -d "${prog_dir}/etc/dss.key" -r "${prog_dir}/etc/rsa.key"
}

# common section
# script hardening
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable
set -o pipefail # propagate last error code on pipe
set -o xtrace   # enable script tracing

# ensure log folder exists
if [ ! -d "${tmp_dir}" ]; then mkdir -p "${tmp_dir}"; fi
# redirect all output to logfile
exec 3>&1 4>&2 1>> "${logfile}" 2>&1
STDOUT=">&3"
STDERR=">&4"
# log current date, time, and invocation parameters
echo "$(date +"%Y-%m-%d %H-%M-%S"): ${0}" "${@}"

main "$@"
