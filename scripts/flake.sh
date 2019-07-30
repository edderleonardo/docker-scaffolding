DC_FILE=${1:-docker-compose.yml}

docker-compose run app flake8
