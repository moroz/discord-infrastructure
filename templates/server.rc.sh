#!/bin/sh

# PROVIDE: {{ app_name }}
# REQUIRE: DAEMON

. /etc/rc.subr
name="{{ app_name }}"
rcvar="{{ app_name }}_enable"

# Set defaults
: ${{ '{' }}{{ app_name }}_enable="NO"}
: ${{ '{' }}{{ app_name }}_user="{{ app_user }}"}
: ${{ '{' }}{{ app_name }}_home_dir="/home/{{ app_user }}"}

envfile="{{ app_base_dir }}/{{ app_name }}.env"
pidfile="/var/run/${name}.pid"
working_dir="{{ app_base_dir }}/current"
command="/usr/sbin/daemon"
procname="{{ app_base_dir }}/current/server"
command_args="-T ${name} -u ${{ '{' }}{{ app_name }}_user} -r -R 5 -P ${pidfile} env ${procname}"

start_cmd="{{ app_name }}_start"
stop_cmd="{{ app_name }}_stop"

{{ app_name }}_start() {
  echo "Starting ${name}."

  [ -f $envfile ] && . $envfile
  su -m ${discord_user} -c "/usr/local/bin/goose up"
  cd $(realpath ${working_dir})
  ${command} ${command_args}
}

{{ app_name }}_stop() {
  echo "Stopping ${name}."
  kill -s TERM "$(cat ${pidfile})"
}

load_rc_config $name

run_rc_command "$1"
