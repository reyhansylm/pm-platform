run:
	go build --trimpath --mod=vendor --buildmode=plugin -o ./build/backend.so
	docker-compose up --build

run-dev-deploy:
	chmod +x ./deploy/Development/deploy.sh
	./deploy/Development/deploy.sh

