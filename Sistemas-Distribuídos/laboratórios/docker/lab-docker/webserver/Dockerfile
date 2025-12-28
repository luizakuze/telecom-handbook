#-it --rm -p 1234:8000 webserver
FROM eclipse-temurin:21

WORKDIR /app

COPY index.html /app

ENTRYPOINT ["jwebserver", "-b", "0.0.0.0"]