deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. py.test --verbose -s
docker_build: 
	docker build -t hello-world-printer . 
	docker run --name hello-world-printer-dev -p 5050:5000 -d hello-world-printer
TAG=$(USERNAME)/hello-world-printer
docker_push: docker_build  
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;