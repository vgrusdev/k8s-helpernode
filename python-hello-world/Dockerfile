FROM python:alpine 
LABEL maintainer="vgrusdev@gmail.com"

RUN pip install flask
COPY src /src/

EXPOSE 5000

ENTRYPOINT ["python", "/src/app.py"]

