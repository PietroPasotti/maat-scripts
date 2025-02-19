PROJECT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

SRC := $(PROJECT)maat-scripts

export PYTHONPATH = $(PROJECT):$(SRC)

lock:
	uv lock -U --no-cache

lint:
	uv tool run ruff check $(ALL)
	uv tool run ruff format --check --diff $(ALL)
	uv run --extra dev pyright

fmt:
	uv tool run ruff check --fix-only $(ALL)
	uv tool run ruff format $(ALL)

unit:
	uv run --isolated --extra dev \
		coverage run --source=$(SRC)/tests \
		-m pytest --tb native -v -s
		$(SRC)/tests \
		$(ARGS)
	uv run --all-extras coverage report

clean:
	rm -rf .coverage
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf .venv
	rm -rf **/__pycache__
	rm -rf **/*.egg-info
	rm -rf requirements*.txt
