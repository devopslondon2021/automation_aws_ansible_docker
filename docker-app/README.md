# Simple Hello-World Python Flask app
A very simple python flask based app that returns hello-world

# Pre-requisites
- Docker 

Build the image using the following command

```bash
$ docker build -t flask-app:latest .
```

Run the Docker container on local host (laptop) using the command shown below.

```bash
$ docker run -d -p 5000:5000 flask-app
```

The application will be accessible at `localhost:5000`
