# General docker abbreviations
set -l run_prefix 'sudo docker run -it --user (id -u)'
abbr -a dr -f "$run_prefix"

# Abbreviations for composer 2
set -l prefix "$run_prefix -v (pwd):/app composer:2 composer"
abbr -a composer "$prefix"
abbr -a co "$prefix"

# Abbreviations for composer 1
set -l prefix "$run_prefix -v (pwd):/app composer:1 composer"
abbr -a composer1 "$prefix"
abbr -a co1 "$prefix"

# General docker-compose abbreviations
set -l prefix 'sudo docker compose'
abbr -a dc "$prefix"
abbr -a dce "$prefix exec"
abbr -a dcu "$prefix up -d"
abbr -a dcl "$prefix logs"
abbr -a dcs "$prefix stop"

# Abbreviations for Symfony applications running within a Docker container
set -l prefix "$prefix exec php"

abbr -a symfony "$prefix bin/console"
abbr -a sym "$prefix bin/console"
abbr -a php "$prefix php"
