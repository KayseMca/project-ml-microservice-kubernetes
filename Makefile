## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	# pip install --upgrade pip &&\
	# 	pip install -r requirements.txt
	pip install --no-cache-dir --upgrade pip &&\
	pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt  \
    && rm -rf /var/lib/apt/lists/*
	
	# wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	# chmod +x /bin/hadolint

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# This is linter for Dockerfiles
	hadolint  --ignore DL3003 --ignore DL3006 Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 app.py

all: install lint test
