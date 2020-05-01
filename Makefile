all:
	docker pull jsalort/py38:latest
	docker build -t jsalort/basilisk:latest .