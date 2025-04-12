#!/bin/sh

# PROVIDE: caddy
# REQUIRE: SERVERS

. /etc/rc.subr
name="caddy"
rcvar="caddy_enable"

# Set defaults
: ${caddy_enable:="no"}
: ${caddy_config="{{ caddyfile_path }}"}
: ${caddy_flags="start" "--config $caddy_config"}
: ${caddy_user="caddy"}
: ${caddy_ender="stop"}

command="/usr/local/bin/${name}"
start_cmd="${name}_start"
stop_cmd="${name}_stop"
sig_reload="USR1"
pidfile="/var/run/${name}.pid"

caddy_start() {
  echo "Starting caddy server."
  /usr/local/bin/sudo -u $caddy_user ${command} ${caddy_flags}
  echo "Started caddy server."
}

caddy_stop() {
  echo"Stopping caddy server."
  /usr/local/bin/sudo -u $caddy_user ${command} ${caddy_ender}
  echo "Stopped caddy server."
}

load_rc_config $name

run_rc_command "$1"
