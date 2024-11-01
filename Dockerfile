FROM python:3.9-alpine

WORKDIR /usr/src/app

COPY index.html /usr/src/app/
COPY styles.css /usr/src/app/
COPY script.js /usr/src/app/

EXPOSE 8000

CMD ["python3", "-m", "http.server", "8000"]
