# 来源镜像
FROM openjdk:8-jdk-alpine
ARG JAR_NAME=eureka-server-0.0.1-SNAPSHOT.jar
ADD ${JAR_NAME} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]