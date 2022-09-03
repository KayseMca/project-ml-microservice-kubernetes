

## Step 1:
# Create a working directory

## Step 2:
# Copy source code to working directory

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
FROM python:3.7.3-stretch

WORKDIR /app

COPY . app.py /app/

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade pip &&\
	pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt
	
COPY . /app
## Step 4:
EXPOSE  80

## Step 5:
# Run app.py at container launch
CMD [ "python", "app.py" ]
