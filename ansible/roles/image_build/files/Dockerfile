FROM openjdk:8-jre-alpine

RUN mkdir /app

COPY app/target/*.jar /app/app.jar

CMD java -jar /app/app.jar && tail -f /dev/null
