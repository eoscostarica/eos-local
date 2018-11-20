setup: scripts/setup.sh
	./scripts/setup.sh

start: scripts/start.sh
	./scripts/start.sh

restart: FORCE
	docker-compose restart

stop: scripts/stop.sh
	./scripts/stop.sh

flush: scripts/flush.sh
	./scripts/flush.sh

logs: FORCE
	docker-compose logs -f

migrate: FORCE
	docker-compose up flyway

psql: FORCE
	docker-compose exec postgres psql -U postgres

FORCE:
