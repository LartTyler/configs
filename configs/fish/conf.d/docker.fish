# General Docker abbreviations
abbr -a dc 'sudo docker-compose'
abbr -a dce 'sudo docker-compose exec'
abbr -a dcu 'sudo docker-compose up -d'
abbr -a dcl 'sudo docker-compose logs'
abbr -a dcs 'sudo docker-compose stop'

# Abbreviations for Symfony applications running within a Docker container
set -l prefix 'sudo docker-compose exec php'

abbr -a composer "$prefix composer"
abbr -a co "$prefix composer"
abbr -a symfony "$prefix bin/console"
abbr -a sym "$prefix bin/console"
abbr -a php "$prefix php"
