.PHONY: lint format

help:
	@echo "lint - check style with black and ruff, sort python with ruff, and indent html"
	@echo "format - enforce a consistent code style across the codebase and sort python files with ruff"

lint-server:
	black --target-version py37 --check --diff .
	ruff check .
	curlylint --parse-only bakerydemo
	git ls-files '*.html' | xargs djhtml --check

lint-client:
	npm run lint:css --silent
	npm run lint:js --silent
	npm run lint:format --silent

lint: lint-server lint-client

format-server:
	black --target-version py37 .
	ruff check . --fix
	git ls-files '*.html' | xargs djhtml -i

format-client:
	npm run format
	npm run fix:js

format: format-server format-client
