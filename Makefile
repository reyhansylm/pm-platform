DEFAULT_VERSION := $(shell cat version.txt)

DEV_VERSION := 1
PROD_VERSION := 1
INTERNAL_VERSION := 1
EXTERNAL_VERSION := 1

run-dev-deploy: increase-dev-version
	export ECR_TAG=$(DEV_VERSION) && \
	go build --trimpath --mod=vendor --buildmode=plugin -o ./deploy/Development/backend.so && \
	chmod +x ./deploy/Development/deploy.sh && \
	./deploy/Development/deploy.sh

run-prod-deploy: increase-prod-version
	export ECR_TAG=$(PROD_VERSION) && \
	go build --trimpath --mod=vendor --buildmode=plugin -o ./deploy/Production/backend.so && \
	chmod +x ./deploy/Production/deploy.sh && \
	./deploy/Production/deploy.sh

run-ext-deploy: increase-external-version
	export ECR_TAG=$(EXTERNAL_VERSION) && \
	go build --trimpath --mod=vendor --buildmode=plugin -o ./deploy/External/backend.so && \
	chmod +x ./deploy/External/deploy.sh && \
	./deploy/External/deploy.sh

run-int-deploy: increase-internal-version
	export ECR_TAG=$(INTERNAL_VERSION) && \
	go build --trimpath --mod=vendor --buildmode=plugin -o ./deploy/Internal/backend.so && \
	chmod +x ./deploy/Internal/deploy.sh && \
	./deploy/Internal/deploy.sh

increase-dev-version:
	@echo "DEV_VERSION=$(DEV_VERSION)" > .env
	@echo $(shell expr $(DEV_VERSION) + 1) > version.txt

increase-prod-version:
	@echo "PROD_VERSION=$(PROD_VERSION)" > .env
	@echo $(shell expr $(PROD_VERSION) + 1) > version.txt

increase-external-version:
	@echo "EXTERNAL_VERSION=$(EXTERNAL_VERSION)" > .env
	@echo $(shell expr $(EXTERNAL_VERSION) + 1) > version.txt

increase-internal-version:
	@echo "INTERNAL_VERSION=$(INTERNAL_VERSION)" > .env
	@echo $(shell expr $(INTERNAL_VERSION) + 1) > version.txt


