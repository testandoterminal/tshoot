# make deploy-prod
deploy-prod:
	@./prepare.sh
	@docker-compose up -d

# make stop
stop:
	@docker-compose down

# make logs
logs:
	@docker-compose logs -f

# make clean
clean:
	@docker-compose down -v --remove-orphans
	@docker-compose rm -f
