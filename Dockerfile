FROM maven:3.6.0-jdk-8-slim as build

# 指定构建过程中的工作目录
WORKDIR /app

COPY src /app/src

COPY pom.xml /app

RUN mvn -f /app/pom.xml clean package

FROM alpine:3.13

ENV MYSQL_HOST 10.0.224.7
ENV MYSQL_USERNAME music
ENV MYSQL_PASSWORD Music2021
ENV DATABASE_NAME yili-music

RUN apk add --update --no-cache openjdk8-jre-base \
    && rm -f /var/cache/apk/*

WORKDIR /app

COPY --from=build /app/target/yili-music-0.0.1.jar .

EXPOSE 8080

CMD ["java","-jar","/app/yili-music-0.0.1.jar"]
