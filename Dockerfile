

## Step 1:
# Create a working directory

FROM python:3.7.3-stretch

WORKDIR /app

COPY . app.py /app/
## Step 2:
# Copy source code to working directory

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade  pip &&\
	pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt  &&\
    rm -rf /var/lib/apt/lists/*

COPY . /app
COPY ./requirements.txt /app/requirements.txt

## Step 4:
EXPOSE  80

## Step 5:
# Run app.py at container launch
CMD [ "python", "app.py" ]
