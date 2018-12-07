source $(dirname $0)/flush.sh

docker volume rm keosd-data-volume

source $(dirname $0)/setup.sh
