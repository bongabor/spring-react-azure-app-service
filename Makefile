.PHONY := all

terraform-validate: 
	cd terraform; \
	terraform init; \
	terraform fmt; \
	terraform validate; \
	terraform plan

terraform-apply:
	cd terraform && \
	terraform init -input=false \
		-backend-config="resource_group_name=MyLowCostVM_group" \
		-backend-config="storage_account_name=tfstateaccount2026" \
		-backend-config="container_name=tfstate" \
		-backend-config="key=prod.tfstate" && \
	terraform apply -auto-approve

terraform-destroy:
	cd terraform; \
	terraform init; \
	terraform destroy --auto-approve

backend-start:
	cd backend; \
	./gradlew bootRun

backend-build:
	cd backend; \
	./gradlew build

backend-ci: 
	cd backend; \
	./gradlew build; \
	./gradlew test

ui-build-nonprod: 
	cd ui; \
	yarn install; \
	yarn build:nonprod; \

ui-ci: 
	cd ui; \
	yarn install; \
	yarn build; \
	yarn test

ui-test-watch:
	cd ui; \
	yarn test:watch   

ui-start:
	cd ui; \
	yarn install; \
	yarn start

start: 
	npx concurrently -n backend,start -c cyan,green "make backend-start" "make ui-start"